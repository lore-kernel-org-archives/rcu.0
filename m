Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792709709;
	b=I2hpyKqpcgt5T+PUGFj2tVaY1LdW/97oFX/xvKRsd0I+Kp1eew1YQiQvOt1POeVuznoe
	 +mAgIjAm45mSPmCyWr9Wxly+gGMNnRN8lwHsxOdkn4XNJE6CChJ23GeSRRgi0NDr/8DwT
	 X/cgwcv3BLwI8eRsRyWmypmYMUpNTe22xrJB4pLpzUT0J2jNdugN5T6ZkGUkRB113U123
	 VvNPOWiFExP5WZEt8F9Hn0J1ySAHkqgZ4BwWEZlFgan9vrB1LsyacLnoBVt3UMY0Jdwbe
	 YsqPi2QtPfBmNOTW3GknCI9nV3kQOzjX+bd+QHoi1ybUVKvlaCKJBORq6eC7g5fdOpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792709709;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=k8xVFxsAd4Z0jpWS50Gow2a+yhVNOnQXG0vCY+x7cLM=;
	b=jJaM0XzSgm+gdOQQS1mPffYYZ0Cy7Qvu1pGvLDq8EeJsqe5fwy9XYdhAtrQH4hsLgFwB
	 Lqy/3gWxuCS8wKmVcnyx0dWFKqAhhj5h3cjda8dl7LD+TiQugE3stJFpFxMEcC7IkOgJr
	 N0RM0zyLh0IBxsXCJk0zFyR5m3zbJ41cT1pi6KWPk/fAlnJCWnmuL5RqwAflmr6vywamw
	 Aj6OVWejeD3F6sWXJDpnhgdxsry6OVOj1sGDo7CC7fXG/JPwPxa+oJmIROwZQANUCYJDt
	 I+Uj+mMfNKJkpc/aGYwc7pTgDx+N7ESqUHjSEzgEOYvtnGzU+/F+PNVlxCilSmVognQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nPgrY9rd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83929606A319;
	Thu, 22 Oct 2026 22:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nPgrY9rd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2F871F01825;
	Thu, 22 Oct 2026 22:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792709708;
	bh=k8xVFxsAd4Z0jpWS50Gow2a+yhVNOnQXG0vCY+x7cLM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nPgrY9rdqub25Kce+xgF8PoZbnzbjZjEy5Ed5PeoDQjTU/UVgAOm99YLPGeivLfWv
	 +8VVL+K4qf9sndLF7S7jHLkqvZ8YMBsnV4BoHWx2XGARx+Gvi4iDPL47R8klUvG2DS
	 G0WXMeO8/YE37FuHWCqM0A/+vKozTuwLe2Xo2kG/C56CL7GcgJEN/Mk6UoeFfqZ5K1
	 zmuBxg9HDyN6sZAvG9rFJYJ6M/exbZ8hJceMisahZaLwsIC/SRvXw4+NqxDjGswwJd
	 AiWlM9VG7FSB+Hq8rULKxp/tzY03GaZM1ZM9X85Swskvu4tF0r/C9YFvkrtc2wpl2j
	 t0kD1+BifHoxw==
Date: Thu, 22 Oct 2026 15:55:06 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: acme@kernel.org, adrian.hunter@intel.com, ddhariwal@google.com,
	eranian@google.com, james.clark@linaro.org, jolsa@kernel.org,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	mingo@redhat.com, peterz@infradead.org, rcu@vger.kernel.org
Subject: Re: [PATCH v6 05/11] perf bpf-filter: Add lock_held() sample filter
 for global mutexes
Message-ID: <atqUSrmtsfCojGcA@google.com>
References: <20261020205859.1080743-1-irogers@google.com>
 <20261022203003.1779152-1-irogers@google.com>
 <20261022203003.1779152-6-irogers@google.com>
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261022203003.1779152-6-irogers@google.com>

On Thu, Oct 22, 2026 at 01:29:57PM -0700, Ian Rogers wrote:
> Add BPF sample filter predicates lock_held(<lock>),
> lock_held_read(<lock>) / lock_held_shared(<lock>), and
> lock_held_write(<lock>) / lock_held_exclusive(<lock>) (as well as ':R'
> and ':W' suffixes on <lock>) to allow recording perf event samples only
> when a specified kernel lock is held (or not held with '!').
> 
> In this initial step, support global/static kernel mutex symbols (e.g.
> lock_held(cgroup_mutex)) resolved via /proc/kallsyms. On sample
> overflow, perf_sample_filter and perf_tp_sample_filter inspect the
> mutex's owner field directly in kernel memory via get_lock_owner()
> without attaching any BPF fentry/fexit hooks.
> 
> Subsequent commits extend lock_held() to other kernel lock types,
> per-process and semi-global locks, slab cache locks, and RCU/SRCU.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/Documentation/perf-record.txt     |  16 +-
>  tools/perf/util/bpf-filter.c                 | 350 ++++++++++++++++++-
>  tools/perf/util/bpf-filter.h                 |  13 +
>  tools/perf/util/bpf-filter.l                 |  31 +-
>  tools/perf/util/bpf-filter.y                 |  47 ++-
>  tools/perf/util/bpf_skel/sample-filter.h     |  36 ++
>  tools/perf/util/bpf_skel/sample_filter.bpf.c |  54 +++
>  tools/perf/util/parse-events.c               |   2 +
>  8 files changed, 530 insertions(+), 19 deletions(-)
> 
> diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
> index fcf1ea62bf1c..445cc98a6c33 100644
> --- a/tools/perf/Documentation/perf-record.txt
> +++ b/tools/perf/Documentation/perf-record.txt
> @@ -210,7 +210,21 @@ OPTIONS
>  	  ip, id, tid, pid, cpu, time, addr, period, txn, weight, phys_addr,
>  	  code_pgsz, data_pgsz, weight1, weight2, weight3, ins_lat, retire_lat,
>  	  p_stage_cyc, mem_op, mem_lvl, mem_snoop, mem_remote, mem_lock,
> -	  mem_dtlb, mem_blk, mem_hops, uid, gid
> +	  mem_dtlb, mem_blk, mem_hops, uid, gid, cgroup, lock_held(<lock>),
> +	  lock_held_read(<lock>), lock_held_shared(<lock>),
> +	  lock_held_write(<lock>), lock_held_exclusive(<lock>)
> +
> +	The 'lock_held(<lock>)' predicate (or '!lock_held(<lock>)') filters
> +	samples based on whether the specified kernel lock is currently held
> +	by the kernel thread.  To differentiate between shared/read holding
> +	and exclusive/write holding, use 'lock_held_read(<lock>)' (alias
> +	'lock_held_shared(<lock>)') or 'lock_held_write(<lock>)' (alias
> +	'lock_held_exclusive(<lock>)'), or append ':R' or ':W' to <lock>.
> +	<lock> can be a kernel mutex symbol name (e.g.
> +	'lock_held(cgroup_mutex)').  When filtering on a mutex symbol
> +	('*_mutex'), 'perf_sample_filter' inspects the lock's 'owner' field
> +	directly in kernel memory on each sample without attaching any BPF
> +	fentry/fexit hooks.
>  
>  	The <operator> can be one of:
>  	  ==, !=, >, >=, <, <=, &
> diff --git a/tools/perf/util/bpf-filter.c b/tools/perf/util/bpf-filter.c
> index 0d3c700d3dcd..639db6c03137 100644
> --- a/tools/perf/util/bpf-filter.c
> +++ b/tools/perf/util/bpf-filter.c
> @@ -43,6 +43,9 @@
>  #include <errno.h>
>  #include <stdio.h>
>  #include <stdlib.h>
> +#include <stdbool.h>
> +#include <stddef.h>
> +#include <string.h>
>  #include <fcntl.h>
>  #include <unistd.h>
>  #include <sys/ioctl.h>
> @@ -50,14 +53,19 @@
>  
>  #include <bpf/bpf.h>
>  #include <linux/err.h>
> +#include <linux/kernel.h>
>  #include <linux/list.h>
> +#include <linux/string.h>
> +#include <linux/zalloc.h>
>  #include <api/fs/fs.h>
>  #include <internal/xyarray.h>
>  #include <perf/threadmap.h>
> +#include <symbol/kallsyms.h>
>  
>  #include "util/cap.h"
>  #include "util/debug.h"
>  #include "util/evsel.h"
> +#include "util/symbol_conf.h"
>  #include "util/target.h"
>  #include "util/thread_map.h"
>  #include "util/bpf-utils.h"
> @@ -126,7 +134,8 @@ static int check_sample_flags(struct evsel *evsel, struct perf_bpf_filter_expr *
>  {
>  	const struct perf_sample_info *info;
>  
> -	if (expr->term == PBF_TERM_UID || expr->term == PBF_TERM_GID) {
> +	if (expr->term == PBF_TERM_UID || expr->term == PBF_TERM_GID ||
> +	    expr->term == PBF_TERM_LOCK_HELD) {
>  		/* Not dependent on the sample_type as computed from a BPF helper. */
>  		return 0;
>  	}
> @@ -169,9 +178,263 @@ static int check_sample_flags(struct evsel *evsel, struct perf_bpf_filter_expr *
>  	return -1;
>  }
>  
> +static int split_lock_name_mode(const char *name, int expr_part,
> +				char *base_buf, size_t buf_sz,
> +				bool *has_amp, unsigned int *mode_out)
> +{
> +	const char *bare;
> +	size_t len;
> +	unsigned int expr_mode = expr_part & PBF_LOCK_MODE_MASK;
> +	unsigned int suffix_mode = 0;
> +
> +	if (!name || !*name)
> +		return -EINVAL;
> +
> +	*has_amp = (name[0] == '&');
> +	bare = *has_amp ? name + 1 : name;
> +	len = strlen(bare);
> +	if (len == 0)
> +		return -EINVAL;
> +
> +	if (len > 2 && !strcmp(bare + len - 2, ":R")) {
> +		suffix_mode = PBF_LOCK_MODE_READ;
> +		len -= 2;
> +	} else if (len > 2 && !strcmp(bare + len - 2, ":W")) {
> +		suffix_mode = PBF_LOCK_MODE_WRITE;
> +		len -= 2;
> +	}
> +
> +	if (len == 0 || len >= buf_sz)
> +		return -EINVAL;
> +
> +	if (expr_mode && expr_mode != PBF_LOCK_MODE_ANY &&
> +	    suffix_mode && expr_mode != suffix_mode)
> +		return -EINVAL;
> +
> +	memcpy(base_buf, bare, len);
> +	base_buf[len] = '\0';
> +
> +	if (suffix_mode)
> +		*mode_out = suffix_mode;
> +	else if (expr_mode)
> +		*mode_out = expr_mode;
> +	else
> +		*mode_out = PBF_LOCK_MODE_ANY;
> +
> +	return 0;
> +}
> +
> +struct lock_sym_cb_args {
> +	const char *name;
> +	u64 addr;
> +	bool in_text;
> +	bool in_data;
> +	bool found;
> +};
> +
> +static int find_lock_sym_cb(void *arg, const char *name, char type, u64 start)
> +{
> +	struct lock_sym_cb_args *args = arg;
> +
> +	if (!strcmp(name, "_text") || !strcmp(name, "_stext") ||
> +	    !strcmp(name, "_sinittext")) {
> +		args->in_text = true;
> +		return 0;
> +	}
> +	if (!strcmp(name, "_etext") || !strcmp(name, "_einittext")) {
> +		args->in_text = false;
> +		return 0;
> +	}
> +	if (!strcmp(name, "_sdata") || !strcmp(name, "__bss_start")) {
> +		args->in_text = false;
> +		args->in_data = true;
> +		return 0;
> +	}
> +	if (!strcmp(name, "__bss_stop")) {
> +		args->in_data = false;
> +		return 0;
> +	}
> +
> +	/*
> +	 * Ignore kernel text functions, module text functions, and
> +	 * absolute/undefined symbols. On CONFIG_LTO_CLANG kernels, vmlinux
> +	 * .data symbols between _sdata and _edata may have kallsyms type
> +	 * 'T'/'t', so allow 'T'/'t' within vmlinux data/bss (args->in_data).
> +	 */
> +	if (args->in_text || type == 'A' || type == 'a' ||
> +	    type == 'U' || type == 'u' ||
> +	    (!args->in_data && kallsyms__is_function(type)))
> +		return 0;
> +
> +	if (!strcmp(name, args->name)) {
> +		args->found = true;
> +		args->addr = start;
> +		if (start != 0)
> +			return 1;
> +	}
> +	return 0;
> +}
> +
> +static int find_kernel_lock_sym(const char *name, u64 *addr)
> +{
> +	struct lock_sym_cb_args args = {
> +		.name = name,
> +	};
> +	const char *kallsyms_filename = "/proc/kallsyms";
> +
> +	if (symbol_conf.kallsyms_name != NULL)
> +		kallsyms_filename = symbol_conf.kallsyms_name;
> +
> +	if (kallsyms__parse(kallsyms_filename, &args, find_lock_sym_cb) < 0)
> +		return -ENOENT;
> +
> +	if (!args.found)
> +		return -ENOENT;
> +
> +	if (args.addr == 0) {
> +		pr_err("Error: Kernel symbol '%s' address is 0 (check permissions / kptr_restrict)\n",
> +		       name);
> +		return -EACCES;
> +	}
> +
> +	*addr = args.addr;
> +	return 0;
> +}
> +
> +static void prescan_one_lock_expr(struct perf_bpf_filter_expr *expr,
> +				  bool *has_lock_filter)
> +{
> +	if (expr->term != PBF_TERM_LOCK_HELD || !expr->lock_name)
> +		return;
> +
> +	*has_lock_filter = true;
> +}
> +
> +static void prescan_lock_filters(struct evsel *evsel, bool *has_lock_filter)
> +{
> +	struct perf_bpf_filter_expr *expr, *group;
> +
> +	*has_lock_filter = false;
> +
> +	list_for_each_entry(expr, &evsel->bpf_filters, list) {
> +		prescan_one_lock_expr(expr, has_lock_filter);
> +		if (expr->op == PBF_OP_GROUP_BEGIN) {
> +			list_for_each_entry(group, &expr->groups, list)
> +				prescan_one_lock_expr(group, has_lock_filter);
> +		}
> +	}
> +}
> +
> +static int normalize_lock_expr_op(const struct perf_bpf_filter_expr *expr,
> +				  enum perf_bpf_filter_op *op_out)
> +{
> +	switch (expr->op) {
> +	case PBF_OP_EQ:
> +		if (expr->val == 1) {
> +			*op_out = PBF_OP_EQ;
> +			return 0;
> +		}
> +		if (expr->val == 0) {
> +			*op_out = PBF_OP_NEQ;
> +			return 0;
> +		}
> +		break;
> +	case PBF_OP_NEQ:
> +		if (expr->val == 0) {
> +			*op_out = PBF_OP_EQ;
> +			return 0;
> +		}
> +		if (expr->val == 1) {
> +			*op_out = PBF_OP_NEQ;
> +			return 0;
> +		}
> +		break;
> +	case PBF_OP_GT:
> +		if (expr->val == 0) {
> +			*op_out = PBF_OP_EQ;
> +			return 0;
> +		}
> +		break;
> +	case PBF_OP_GE:
> +		if (expr->val == 1) {
> +			*op_out = PBF_OP_EQ;
> +			return 0;
> +		}
> +		break;
> +	case PBF_OP_LT:
> +		if (expr->val == 1) {
> +			*op_out = PBF_OP_NEQ;
> +			return 0;
> +		}
> +		break;
> +	case PBF_OP_LE:
> +		if (expr->val == 0) {
> +			*op_out = PBF_OP_NEQ;
> +			return 0;
> +		}
> +		break;
> +	case PBF_OP_AND:
> +		if (expr->val & 1) {
> +			*op_out = PBF_OP_EQ;
> +			return 0;
> +		}
> +		break;
> +	case PBF_OP_GROUP_BEGIN:
> +	case PBF_OP_GROUP_END:
> +	case PBF_OP_DONE:
> +	default:
> +		break;
> +	}
> +	pr_err("Error: Invalid comparison for boolean lock_held(%s) predicate\n",
> +	       expr->lock_name ?: "");
> +	return -EINVAL;
> +}
> +
> +static int resolve_lock_expr(struct perf_bpf_filter_expr *expr,
> +			     struct perf_bpf_filter_entry *entry)
> +{
> +	const char *name = expr->lock_name;
> +	char base[128];
> +	bool has_amp;
> +	unsigned int mode;
> +	u64 addr = 0;
> +	int ret;
> +
> +	ret = normalize_lock_expr_op(expr, &entry->op);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (split_lock_name_mode(name, expr->part, base, sizeof(base),
> +				 &has_amp, &mode) < 0 || has_amp) {
> +		pr_err("Error: Invalid kernel lock filter '%s'\n", name ?: "");
> +		return -EINVAL;
> +	}
> +
> +	if (str_ends_with(base, "mutex") &&
> +	    !str_ends_with(base, "rt_mutex") &&
> +	    !str_ends_with(base, "rtmutex")) {

Is it just checking the symbol name ends with "mutex" or so?  It seems
risky and limited, can we check BTF to verify if it's really a mutex?

Thanks,
Namhyung


> +		ret = find_kernel_lock_sym(base, &addr);
> +		if (ret == 0) {
> +			if (!(mode & PBF_LOCK_MODE_WRITE)) {
> +				pr_err("Error: Lock '%s' is exclusive and does not support read/shared mode\n",
> +				       name);
> +				return -EINVAL;
> +			}
> +			entry->part = PBF_LOCK_ADDR | mode | PBF_LOCK_DIRECT_MUTEX;
> +			entry->value = addr;
> +			return 0;
> +		}
> +		if (ret == -EACCES)
> +			return ret;
> +	}
> +
> +	pr_err("Error: Cannot resolve kernel lock '%s'\n", name);
> +	return -EINVAL;
> +}
> +
>  static int get_filter_entries(struct evsel *evsel, struct perf_bpf_filter_entry *entry)
>  {
> -	int i = 0;
> +	int i = 0, ret;
>  	struct perf_bpf_filter_expr *expr;
>  
>  	list_for_each_entry(expr, &evsel->bpf_filters, list) {
> @@ -185,6 +448,11 @@ static int get_filter_entries(struct evsel *evsel, struct perf_bpf_filter_entry
>  		entry[i].part = expr->part;
>  		entry[i].term = expr->term;
>  		entry[i].value = expr->val;
> +		if (expr->term == PBF_TERM_LOCK_HELD) {
> +			ret = resolve_lock_expr(expr, &entry[i]);
> +			if (ret < 0)
> +				return ret;
> +		}
>  		i++;
>  
>  		if (expr->op == PBF_OP_GROUP_BEGIN) {
> @@ -198,6 +466,11 @@ static int get_filter_entries(struct evsel *evsel, struct perf_bpf_filter_entry
>  				entry[i].part = group->part;
>  				entry[i].term = group->term;
>  				entry[i].value = group->val;
> +				if (group->term == PBF_TERM_LOCK_HELD) {
> +					ret = resolve_lock_expr(group, &entry[i]);
> +					if (ret < 0)
> +						return ret;
> +				}
>  				i++;
>  			}
>  
> @@ -440,20 +713,24 @@ int perf_bpf_filter__prepare(struct evsel *evsel, struct target *target)
>  	struct perf_bpf_filter_entry *entry;
>  	bool needs_idx_hash = !target__has_cpu(target);
>  	bool is_tracepoint = (evsel->core.attr.type == PERF_TYPE_TRACEPOINT);
> +	bool has_lock_filter = false;
>  
>  	entry = calloc(MAX_FILTERS, sizeof(*entry));
>  	if (entry == NULL)
>  		return -1;
>  
> -	ret = get_filter_entries(evsel, entry);
> -	if (ret < 0) {
> -		pr_err("Failed to process filter entries\n");
> +	prescan_lock_filters(evsel, &has_lock_filter);
> +
> +	if ((has_lock_filter || is_tracepoint) && geteuid() != 0 &&
> +	    !perf_cap__capable(CAP_BPF)) {
> +		pr_err("Error: BPF filter requires CAP_BPF capability\n");
> +		ret = -EPERM;
>  		goto err;
>  	}
>  
> -	if (is_tracepoint && geteuid() != 0 && !perf_cap__capable(CAP_BPF)) {
> -		pr_err("Error: Tracepoint BPF filter requires CAP_BPF capability\n");
> -		ret = -EPERM;
> +	ret = get_filter_entries(evsel, entry);
> +	if (ret < 0) {
> +		pr_err("Failed to process filter entries\n");
>  		goto err;
>  	}
>  
> @@ -513,6 +790,9 @@ int perf_bpf_filter__prepare(struct evsel *evsel, struct target *target)
>  		goto err;
>  	}
>  
> +	if (has_lock_filter)
> +		skel->bss->lock_enabled = 1;
> +
>  	i = 0;
>  	fd = bpf_map__fd(skel->maps.filters);
>  
> @@ -571,6 +851,21 @@ int perf_bpf_filter__prepare(struct evsel *evsel, struct target *target)
>  	return ret;
>  }
>  
> +void perf_bpf_filter_expr__delete(struct perf_bpf_filter_expr *expr)
> +{
> +	struct perf_bpf_filter_expr *group, *tmp;
> +
> +	if (!expr)
> +		return;
> +
> +	list_for_each_entry_safe(group, tmp, &expr->groups, list) {
> +		list_del(&group->list);
> +		perf_bpf_filter_expr__delete(group);
> +	}
> +	zfree(&expr->lock_name);
> +	free(expr);
> +}
> +
>  int perf_bpf_filter__destroy(struct evsel *evsel)
>  {
>  	struct perf_bpf_filter_expr *expr, *tmp;
> @@ -578,7 +873,7 @@ int perf_bpf_filter__destroy(struct evsel *evsel)
>  
>  	list_for_each_entry_safe(expr, tmp, &evsel->bpf_filters, list) {
>  		list_del(&expr->list);
> -		free(expr);
> +		perf_bpf_filter_expr__delete(expr);
>  	}
>  	sample_filter_bpf__destroy(evsel->bpf_skel);
>  
> @@ -630,7 +925,7 @@ struct perf_bpf_filter_expr *perf_bpf_filter_expr__new(enum perf_bpf_filter_term
>  {
>  	struct perf_bpf_filter_expr *expr;
>  
> -	expr = malloc(sizeof(*expr));
> +	expr = zalloc(sizeof(*expr));
>  	if (expr != NULL) {
>  		expr->term = term;
>  		expr->part = part;
> @@ -641,6 +936,28 @@ struct perf_bpf_filter_expr *perf_bpf_filter_expr__new(enum perf_bpf_filter_term
>  	return expr;
>  }
>  
> +struct perf_bpf_filter_expr *perf_bpf_filter_expr__new_lock(const char *lock_name,
> +							    int mode,
> +							    enum perf_bpf_filter_op op,
> +							    unsigned long val)
> +{
> +	struct perf_bpf_filter_expr *expr;
> +
> +	if (!lock_name || !*lock_name)
> +		return NULL;
> +
> +	expr = perf_bpf_filter_expr__new(PBF_TERM_LOCK_HELD, mode, op, val);
> +	if (!expr)
> +		return NULL;
> +
> +	expr->lock_name = strdup(lock_name);
> +	if (!expr->lock_name) {
> +		free(expr);
> +		return NULL;
> +	}
> +	return expr;
> +}
> +
>  static bool check_bpf_filter_capable(void)
>  {
>  	int fd;
> @@ -661,14 +978,11 @@ static bool check_bpf_filter_capable(void)
>  	return false;
>  }
>  
> -int perf_bpf_filter__parse(struct list_head *expr_head, const char *str)
> +int __perf_bpf_filter__parse(struct list_head *expr_head, const char *str)
>  {
>  	YY_BUFFER_STATE buffer;
>  	int ret;
>  
> -	if (!check_bpf_filter_capable())
> -		return -EPERM;
> -
>  	buffer = perf_bpf_filter__scan_string(str);
>  
>  	ret = perf_bpf_filter_parse(expr_head);
> @@ -680,6 +994,14 @@ int perf_bpf_filter__parse(struct list_head *expr_head, const char *str)
>  	return ret;
>  }
>  
> +int perf_bpf_filter__parse(struct list_head *expr_head, const char *str)
> +{
> +	if (!check_bpf_filter_capable())
> +		return -EPERM;
> +
> +	return __perf_bpf_filter__parse(expr_head, str);
> +}
> +
>  /*
>   * perf_bpf_filter__pin() and perf_bpf_filter__unpin() only load
>   * perf_sample_filter and disable autoload on other programs in the skeleton
> diff --git a/tools/perf/util/bpf-filter.h b/tools/perf/util/bpf-filter.h
> index 818c554b91b2..fda95ff226b3 100644
> --- a/tools/perf/util/bpf-filter.h
> +++ b/tools/perf/util/bpf-filter.h
> @@ -14,6 +14,13 @@ struct perf_bpf_filter_expr {
>  	int part;
>  	enum perf_bpf_filter_term term;
>  	unsigned long val;
> +	/*
> +	 * Raw lock descriptor string for PBF_TERM_LOCK_HELD expressions
> +	 * (e.g. "&cgroup_mutex", "mmap_lock", "&dentry", "rwsem:R").
> +	 * Resolved into `entry.part` and `entry.target` during
> +	 * perf_bpf_filter__prepare().
> +	 */
> +	char *lock_name;
>  };
>  
>  struct evsel;
> @@ -27,6 +34,12 @@ struct perf_bpf_filter_expr *perf_bpf_filter_expr__new(enum perf_bpf_filter_term
>  						       int part,
>  						       enum perf_bpf_filter_op op,
>  						       unsigned long val);
> +struct perf_bpf_filter_expr *perf_bpf_filter_expr__new_lock(const char *lock_name,
> +							    int mode,
> +							    enum perf_bpf_filter_op op,
> +							    unsigned long val);
> +void perf_bpf_filter_expr__delete(struct perf_bpf_filter_expr *expr);
> +int __perf_bpf_filter__parse(struct list_head *expr_head, const char *str);
>  int perf_bpf_filter__parse(struct list_head *expr_head, const char *str);
>  int perf_bpf_filter__prepare(struct evsel *evsel, struct target *target);
>  int perf_bpf_filter__destroy(struct evsel *evsel);
> diff --git a/tools/perf/util/bpf-filter.l b/tools/perf/util/bpf-filter.l
> index 1be9df6550fc..b4022110f1e5 100644
> --- a/tools/perf/util/bpf-filter.l
> +++ b/tools/perf/util/bpf-filter.l
> @@ -1,9 +1,12 @@
>  %option prefix="perf_bpf_filter_"
>  %option noyywrap
>  
> +%x LOCK_ARG
> +
>  %{
>  #include <stdio.h>
>  #include <stdlib.h>
> +#include <string.h>
>  #include <linux/perf_event.h>
>  
>  #include "bpf-filter.h"
> @@ -76,7 +79,7 @@ static int path_or_error(void)
>  num_dec		[0-9]+
>  num_hex		0[Xx][0-9a-fA-F]+
>  space		[ \t]+
> -path		[^ \t\n,]+
> +path		[^ \t\n,()!=>&|<]+
>  ident		[_a-zA-Z][_a-zA-Z0-9]+
>  
>  %%
> @@ -116,7 +119,31 @@ mem_hops	{ return sample_part(PBF_TERM_DATA_SRC, 8); }
>  uid		{ return sample(PBF_TERM_UID); }
>  gid		{ return sample(PBF_TERM_GID); }
>  cgroup		{ return sample_path(PBF_TERM_CGROUP); }
> -
> +lock_held[ \t]*"("	{
> +				BEGIN(LOCK_ARG);
> +				perf_bpf_filter_lval.num = PBF_LOCK_MODE_ANY;
> +				return BFT_LOCK_HELD;
> +			}
> +(lock_held_read|lock_held_shared)[ \t]*"("	{
> +				BEGIN(LOCK_ARG);
> +				perf_bpf_filter_lval.num = PBF_LOCK_MODE_READ;
> +				return BFT_LOCK_HELD;
> +			}
> +(lock_held_write|lock_held_exclusive)[ \t]*"("	{
> +				BEGIN(LOCK_ARG);
> +				perf_bpf_filter_lval.num = PBF_LOCK_MODE_WRITE;
> +				return BFT_LOCK_HELD;
> +			}
> +
> +<LOCK_ARG>{space}	{ }
> +<LOCK_ARG>[^ \t\n()]+	{
> +				perf_bpf_filter_lval.lock_name = strdup(perf_bpf_filter_text);
> +				return BFT_LOCK_NAME;
> +			}
> +<LOCK_ARG>")"		{ BEGIN(INITIAL); return ')'; }
> +<LOCK_ARG>.|\n		{ BEGIN(INITIAL); return BFT_ERROR; }
> +
> +"!"		{ return '!'; }
>  "=="		{ return operator(PBF_OP_EQ); }
>  "!="		{ return operator(PBF_OP_NEQ); }
>  ">"		{ return operator(PBF_OP_GT); }
> diff --git a/tools/perf/util/bpf-filter.y b/tools/perf/util/bpf-filter.y
> index 5a79a8e7a45b..5ae05d4608c6 100644
> --- a/tools/perf/util/bpf-filter.y
> +++ b/tools/perf/util/bpf-filter.y
> @@ -8,9 +8,11 @@
>  #endif
>  
>  #include <stdio.h>
> +#include <stdlib.h>
>  #include <string.h>
>  #include <linux/compiler.h>
>  #include <linux/list.h>
> +#include <linux/zalloc.h>
>  #include "bpf-filter.h"
>  #include "cgroup.h"
>  
> @@ -31,6 +33,11 @@ static void perf_bpf_filter_error(struct list_head *expr __maybe_unused,
>  {
>  	unsigned long num;
>  	char *path;
> +	char *lock_name;
> +	struct {
> +		char *name;
> +		int mode;
> +	} lock;
>  	struct {
>  		enum perf_bpf_filter_term term;
>  		int part;
> @@ -40,12 +47,17 @@ static void perf_bpf_filter_error(struct list_head *expr __maybe_unused,
>  }
>  
>  %token BFT_SAMPLE BFT_SAMPLE_PATH BFT_OP BFT_ERROR BFT_NUM BFT_LOGICAL_OR BFT_PATH
> +%token BFT_LOCK_HELD BFT_LOCK_NAME
>  %type <expr> filter_term filter_expr
> -%destructor { free ($$); } <expr>
> +%destructor { perf_bpf_filter_expr__delete($$); } <expr>
> +%destructor { free($$); } <lock_name>
> +%destructor { free($$.name); } <lock>
>  %type <sample> BFT_SAMPLE BFT_SAMPLE_PATH
>  %type <op> BFT_OP
> -%type <num> BFT_NUM
> +%type <num> BFT_NUM BFT_LOCK_HELD
>  %type <path> BFT_PATH
> +%type <lock_name> BFT_LOCK_NAME
> +%type <lock> lock_term
>  
>  %%
>  
> @@ -105,5 +117,36 @@ BFT_SAMPLE_PATH BFT_OP BFT_PATH
>  	$$ = perf_bpf_filter_expr__new($1.term, $1.part, $2, cgroup_id);
>  	cgroup__put(cgrp);
>  }
> +|
> +lock_term
> +{
> +	$$ = perf_bpf_filter_expr__new_lock($1.name, $1.mode, PBF_OP_EQ, 1);
> +	zfree(&$1.name);
> +	if (!$$)
> +		YYERROR;
> +}
> +|
> +'!' lock_term
> +{
> +	$$ = perf_bpf_filter_expr__new_lock($2.name, $2.mode, PBF_OP_EQ, 0);
> +	zfree(&$2.name);
> +	if (!$$)
> +		YYERROR;
> +}
> +|
> +lock_term BFT_OP BFT_NUM
> +{
> +	$$ = perf_bpf_filter_expr__new_lock($1.name, $1.mode, $2, $3);
> +	zfree(&$1.name);
> +	if (!$$)
> +		YYERROR;
> +}
> +
> +lock_term:
> +BFT_LOCK_HELD BFT_LOCK_NAME ')'
> +{
> +	$$.name = $2;
> +	$$.mode = $1;
> +}
>  
>  %%
> diff --git a/tools/perf/util/bpf_skel/sample-filter.h b/tools/perf/util/bpf_skel/sample-filter.h
> index 683fec85e71e..ca1cf586ed6e 100644
> --- a/tools/perf/util/bpf_skel/sample-filter.h
> +++ b/tools/perf/util/bpf_skel/sample-filter.h
> @@ -53,8 +53,44 @@ enum perf_bpf_filter_term {
>  	/* Terms computed from BPF helpers. */
>  	PBF_TERM_UID,
>  	PBF_TERM_GID,
> +	/*
> +	 * Kernel lock held predicate (`lock_held(...)`). Evaluates whether the
> +	 * specified kernel lock is currently held by the running task/CPU.
> +	 * The lock specification kind is stored in `entry.part`
> +	 * (`enum perf_bpf_lock_target_kind`), `entry.op` is normalized to
> +	 * `PBF_OP_EQ` (match when held) or `PBF_OP_NEQ` (match when not held),
> +	 * and the resolved target address is stored in `entry.value`.
> +	 */
> +	PBF_TERM_LOCK_HELD,
>  };
>  
> +/*
> + * Lock target categories for PBF_TERM_LOCK_HELD filters.
> + * Stored in `perf_bpf_filter_entry.part`.
> + */
> +enum perf_bpf_lock_target_kind {
> +	PBF_LOCK_NONE = 0,
> +	/*
> +	 * Specific global or static lock address resolved from kallsyms.
> +	 * `entry.value` holds the kernel address.
> +	 */
> +	PBF_LOCK_ADDR,
> +};
> +
> +/*
> + * `perf_bpf_filter_entry.part` layout for PBF_TERM_LOCK_HELD:
> + *   Bits 0..3: `enum perf_bpf_lock_target_kind`
> + *   Bit  4:    PBF_LOCK_MODE_READ      (match read/shared lock holding)
> + *   Bit  5:    PBF_LOCK_MODE_WRITE     (match write/exclusive lock holding)
> + *   Bit  6:    PBF_LOCK_DIRECT_MUTEX   (inspect struct mutex owner)
> + */
> +#define PBF_LOCK_KIND_MASK	0x0fU
> +#define PBF_LOCK_MODE_READ	(1U << 4)
> +#define PBF_LOCK_MODE_WRITE	(1U << 5)
> +#define PBF_LOCK_MODE_ANY	(PBF_LOCK_MODE_READ | PBF_LOCK_MODE_WRITE)
> +#define PBF_LOCK_MODE_MASK	PBF_LOCK_MODE_ANY
> +#define PBF_LOCK_DIRECT_MUTEX	(1U << 6)
> +
>  /* BPF map entry for filtering */
>  struct perf_bpf_filter_entry {
>  	enum perf_bpf_filter_op op;
> diff --git a/tools/perf/util/bpf_skel/sample_filter.bpf.c b/tools/perf/util/bpf_skel/sample_filter.bpf.c
> index a190374ed87a..42556ab0e2d5 100644
> --- a/tools/perf/util/bpf_skel/sample_filter.bpf.c
> +++ b/tools/perf/util/bpf_skel/sample_filter.bpf.c
> @@ -5,6 +5,7 @@
>  #include <bpf/bpf_tracing.h>
>  #include <bpf/bpf_core_read.h>
>  
> +#include "lock_data.h"
>  #include "sample-filter.h"
>  
>  /* BPF map that will be filled by user space */
> @@ -45,8 +46,57 @@ struct lost_count {
>  
>  volatile const int use_idx_hash;
>  
> +/* Control flag set by userspace when lock_held(...) filters are active. */
> +int lock_enabled;
> +
>  void *bpf_cast_to_kern_ctx(void *) __ksym;
>  
> +static __always_inline bool is_direct_lock_owner(__u64 lock_addr, __u64 curr, __u32 part)
> +{
> +	if (!curr)
> +		return false;
> +
> +	if ((part & PBF_LOCK_DIRECT_MUTEX) &&
> +	    (__u64)get_lock_owner(lock_addr, LCB_F_MUTEX) == curr)
> +		return true;
> +	return false;
> +}
> +
> +static __always_inline bool is_lock_held(struct perf_bpf_filter_entry *entry)
> +{
> +	__u64 curr = bpf_get_current_task();
> +	__u32 kind = entry->part & PBF_LOCK_KIND_MASK;
> +	__u32 mode = entry->part & PBF_LOCK_MODE_MASK;
> +
> +	if (!mode)
> +		mode = PBF_LOCK_MODE_ANY;
> +
> +	switch (kind) {
> +	case PBF_LOCK_ADDR:
> +		if ((mode & PBF_LOCK_MODE_WRITE) &&
> +		    is_direct_lock_owner(entry->value, curr, entry->part))
> +			return true;
> +		return false;
> +
> +	default:
> +		return false;
> +	}
> +}
> +
> +static __always_inline __u64 check_lock_held(struct perf_bpf_filter_entry *entry)
> +{
> +	/*
> +	 * Pinned filters (use_idx_hash != 0) share a world-writable filters
> +	 * map and do not support lock_held(). Reject evaluation when pinned
> +	 * or when lock_enabled is not set so unprivileged users cannot probe
> +	 * arbitrary kernel addresses via entry->value.
> +	 */
> +	if (use_idx_hash || !lock_enabled)
> +		return entry->op == PBF_OP_EQ ? ~entry->value : entry->value;
> +
> +	return is_lock_held(entry) ? entry->value : ~entry->value;
> +}
> +
>  /* new kernel perf_sample_data definition */
>  struct perf_sample_data___new {
>  	__u64 sample_flags;
> @@ -175,6 +225,8 @@ static inline __u64 perf_get_sample(struct bpf_perf_event_data_kern *kctx,
>  		return bpf_get_current_uid_gid() & 0xFFFFFFFF;
>  	case PBF_TERM_GID:
>  		return bpf_get_current_uid_gid() >> 32;
> +	case PBF_TERM_LOCK_HELD:
> +		return check_lock_held(entry);
>  	case PBF_TERM_NONE:
>  	case __PBF_UNUSED_TERM4:
>  	case __PBF_UNUSED_TERM5:
> @@ -209,6 +261,8 @@ static __always_inline __u64 perf_get_common_sample(struct perf_bpf_filter_entry
>  		return bpf_get_current_uid_gid() & 0xFFFFFFFF;
>  	case PBF_TERM_GID:
>  		return bpf_get_current_uid_gid() >> 32;
> +	case PBF_TERM_LOCK_HELD:
> +		return check_lock_held(entry);
>  	default:
>  		return 0;
>  	}
> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> index d6bab89ade5d..da687e9d1a67 100644
> --- a/tools/perf/util/parse-events.c
> +++ b/tools/perf/util/parse-events.c
> @@ -2621,6 +2621,8 @@ static bool is_possible_tp_filter(struct evsel *evsel, const char *str)
>  {
>  	static const char *const bpf_tp_terms[] = {
>  		"uid", "gid", "tid", "pid", "cpu", "time", "cgroup",
> +		"lock_held", "lock_held_read", "lock_held_shared",
> +		"lock_held_write", "lock_held_exclusive",
>  	};
>  
>  	for (size_t i = 0; i < ARRAY_SIZE(bpf_tp_terms); i++) {
> -- 
> 2.56.0.307.g5fe7bd680c-goog
> 
