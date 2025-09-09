const Search = ({
  value,
  handleSearch,
}: {
  value: string;
  handleSearch: (searchTerm: string) => void;
}) => {
  return (
    <>
      <input
        type='text'
        value={value}
        onChange={(e) => handleSearch(e.target.value)}
      />
    </>
  );
};

export default Search;
