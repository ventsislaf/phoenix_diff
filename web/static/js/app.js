// Brunch automatically concatenates all files in your
// watched paths. Those paths can be configured at
// config.paths.watched in "brunch-config.js".
//
// However, those files will only be executed if
// explicitly imported. The only exception are files
// in vendor, which are never wrapped in imports and
// therefore are always executed.

// Import dependencies
//
// If you no longer want to use a dependency, remember
// to also remove its path from "config.paths.watched".
import "deps/phoenix_html/web/static/js/phoenix_html"

// Import local files
//
// Local files can be imported directly using relative
// paths "./socket" or full ones "web/static/js/socket".

// import socket from "./socket"

class VersionSelect extends React.Component {
  createOption(version) {
    return <option key={version} value={version}>{version}</option>;
  }

  render() {
    return (
      <select defaultValue={this.props.selected} onChange={this.props.onChange}
          name={this.props.name}>
        {this.props.versions.map(this.createOption)}
      </select>
    );
  }
}

class Form extends React.Component {
  constructor(props) {
    super(props);

    const VERSIONS = ["v0.17.1", "v1.0.0", "v1.0.1", "v1.0.2"];

    this.state = {
      versions: VERSIONS,
      sourceSelected: VERSIONS[VERSIONS.length - 2]
    };
  }

  sourceVersions() {
    return this.state.versions.slice(0, -1);
  }

  targetVersions() {
    let selectedIndex = this.state.versions.indexOf(this.state.sourceSelected);
    return this.state.versions.slice(selectedIndex + 1);
  }

  onSourceChange(event) {
    this.setState({
      sourceSelected: event.target.value
    });
  }

  render() {
    return (
      <form method="GET" action="/diff">
        <VersionSelect versions={this.sourceVersions()}
          selected={this.state.sourceSelected}
          onChange={this.onSourceChange.bind(this)}
          name="source" />

        <VersionSelect versions={this.targetVersions()} name="target" />

        <input type="submit" value="View Diff" />
      </form>
    );
  }
}

window.onload = () => {
  let element = document.getElementById("form");
  if (element) {
    React.render(<Form />, element);
  }
}
