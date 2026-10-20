Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792529959;
	b=hbX5BAS0LxNnCLqaAfDTws1NM6KjDcpemIyCBJ+AxViKZYDaS60LRtysOsjZ3BDhnQip
	 RfcnoSVA9bYlrGbvLc5Oqr+wjbLFJDLzwcpCzOo3qXqZPpZTXLrwWC0Qi1H/pKZt17Ytc
	 tHVg39fsZkX9UDrqlT85ElfTQbezaKkY+ax8yk6oUj7c9ezPAH+RxTT8Qb+btVdqB0Cg8
	 /po5sSPBQMzKDtN3lVB1oDq16CKEAD0aHoVMy9MIu6LQWj1WRYhS7EcciJ8bomZOeVTqn
	 3ySCEILxuYklkldJN4kExdZDLXI/c6Be5EPgUHzClMbu0NmyXuJMNbfXpzD7dnFJhlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792529959;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=HzuMjlccNvnuPDgeaG26QeM44soaPjxCdKglKEDbd5g=;
	b=rT+1gp/iQa/KOIXpdxC8OuRE6lLnaN5VzDnzvt4TwZpuiH3wAICWh9WdsWG8nCFP+PPK
	 x96y8LHTdl9hk0poCuDP6fWurID+lpDuBioon1aOGsUkdEFfiPNu7BvVC6rUE4oGaDL6R
	 L/OfwrhEXFRorlwhNJuzvlBB4hHcMaX5c+Cm6WoCMkEkpC0LdhdHRHKeBIQzMY6WJXPct
	 nxkTmujzEX00s1MSqQxKfXNno5XjsvutUvCt3130B4mwsJFF4uC46WEsbX3i5ExXKt/9c
	 LMm9tpyVH8lmcNqKP+hrwMCffnnvEkwE8eXx2Nj5LTbJ1m7Zxi1/jaUB5Q5nOSl0Xew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=XdL1tzJL;
	arc=none smtp.remote-ip=74.125.82.198
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58842606A330
	for <rcu@vger.kernel.org>; Tue, 20 Oct 2026 20:59:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 58842606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=XdL1tzJL
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-341eff9e381so10289021eec.1
        for <rcu@vger.kernel.org>; Tue, 20 Oct 2026 13:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792529958; x=1793134758; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HzuMjlccNvnuPDgeaG26QeM44soaPjxCdKglKEDbd5g=;
        b=XdL1tzJLUKR2mKVRO3gU3jC164QPaJAvYfMOAidT5guifK/oqBlN/JkFjGR6aLjS+W
         r9MwXq2jW1l29wY6gWB8YPxqkpFV67yJKeGxE4dedHRNNEpUyH/AJAkFR9IZlWUb0I6e
         9f/FCORX7rTjR9Og6e6Jv1ie524M5EeVvdT3lPtXFkvhkcZgMaNx9xvo+xcpRxFUfMVP
         0VCxxbDEy4c2nXKKH+4TDY6RHHkY5564BCY/q1T4FrmIIWjh7JYypDfP+JdsQdn+NliZ
         SrcU08EsTXKN71EqirI75I+gj+bZUwEQw0A0qNIspQPZEYj/wjYLsR1g136xHlF1PPCu
         UbQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792529958; x=1793134758;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HzuMjlccNvnuPDgeaG26QeM44soaPjxCdKglKEDbd5g=;
        b=otx6elKeFxXTaiJXPK/P/wLRGJY29btMeEOfvZ8U9um5s0hyw8hNxB1pKft1j3PnwW
         XcrlDRh9DB1+lRoMF8AJIeAkoePvqxYGAHewdMikidYzF95EOf3cIVATuriC6zVMrr4w
         PO5EJiC6ILeDNBVFkf+NJYwIGHOsh3o45/4SOpatTEdDwnZBr4edhjKDYciILZtJYNGr
         mupNQ+CU/ELtCUQWkWaQQ8v4Wx1L+DOmIbAwbR0zthf84JP+3Ol/syCWYsnbf2hbIzly
         f+yYdTxl5KskQES8StORQr+zTxtuikPYRoyNA4XEcY5B4HolH0H3+N3ckZ9rCqr/Htar
         xp8A==
X-Forwarded-Encrypted: i=1; AKwUvBzBWAvIaY7FDX0T7BU3UTzhClZLz0+LqWxpTa278WeQZReeSE6GYOdyvmXZi3m9UN9celw=@vger.kernel.org
X-Gm-Message-State: AFq9FYInqHmnUImozwHuF6wNj/Mc32X3fMmVASJ1ziwM6k4PiMYfjHT5
	+xD20W4PfPmsBVK6gZN6njAeDyoG5fGxBB6Sydq9dhaWp5eHaj+eF4VA681KnJIEev8sMYdMVbO
	hOQ+kQ+H6Sw==
X-Received: from dlbtp2.prod.google.com ([2002:a05:7022:3b82:b0:15b:797b:2b69])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701a:c973:b0:17d:7b45:f907
 with SMTP id a92af1059eb24-190a7380c5dmr9065c88.33.1792529958000; Tue, 20 Oct
 2026 13:59:18 -0700 (PDT)
Date: Tue, 20 Oct 2026 13:58:52 -0700
In-Reply-To: <20261020205859.1080743-1-irogers@google.com>
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261019220915.3943592-1-irogers@google.com> <20261020205859.1080743-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
Message-ID: <20261020205859.1080743-3-irogers@google.com>
Subject: [PATCH v5 2/8] perf bpf-filter: Fix bpf_link leak by using PERF_EVENT_IOC_SET_BPF
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, ddhariwal@google.com, eranian@google.com, 
	james.clark@linaro.org, jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

In perf_bpf_filter__prepare(), the unpinned filter path attaches
skel->progs.perf_sample_filter to each FD(evsel, x, y) using
bpf_program__attach_perf_event_opts() and ignores the returned
struct bpf_link *, leaking the allocated struct bpf_link_perf and its
BPF_PERF_EVENT link fd.

Furthermore, bpf_program__attach_perf_event_opts() is designed for
callers that transfer ownership of the perf_event fd to the returned
bpf_link: when bpf_link__destroy() is called, bpf_link_perf_detach()
unconditionally disables and closes perf_link->perf_event_fd. Because
evsel->core.fd owns FD(evsel, x, y) and closes them in evlist__close(),
destroying the returned bpf_link would double-close the perf_event file
descriptors.

Fix this by attaching the program directly with
ioctl(FD(evsel, x, y), PERF_EVENT_IOC_SET_BPF, fd), matching the pinned
filter path right above it in perf_bpf_filter__prepare(). In the
kernel, PERF_EVENT_IOC_SET_BPF takes a reference on the BPF program and
_free_event() -> perf_event_free_bpf_prog() automatically detaches and
releases it when the perf_event fd is closed. This also avoids enabling
the event prematurely, allowing pe_opts (.dont_enable = true) and the
LIBBPF_CURRENT_VERSION_GEQ(1, 7) guard to be dropped.

Before (built with EXTRA_CFLAGS="-fsanitize=address"):
  # perf record -e cycles --filter 'period > 1000' -- true
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.024 MB perf.data ]

  =================================================================
  ==51328==ERROR: LeakSanitizer: detected memory leaks

  Direct leak of 1568 byte(s) in 28 object(s) allocated from:
      #0 0x7ffbe76ef24f in calloc (/lib64/libasan.so.8+0xef24f)
      #1 0x625df7 in bpf_program__attach_perf_event_opts (tools/perf/perf+0x625df7)
      #2 0xbeddc0 in perf_bpf_filter__prepare util/bpf-filter.c:507
      #3 0x8f3def in evlist__apply_filters util/evlist.c:1421
      #4 0x44bbcf in record__open tools/perf/builtin-record.c:1469
      #5 0x453f9e in __cmd_record tools/perf/builtin-record.c:2594
      #6 0x45dadb in cmd_record tools/perf/builtin-record.c:4427
      #7 0x5df56b in run_builtin tools/perf/perf.c:383
      #8 0x5dfa0e in handle_internal_command tools/perf/perf.c:436
      #9 0x5dfddc in run_argv tools/perf/perf.c:480
      #10 0x5e0333 in main tools/perf/perf.c:581

  SUMMARY: AddressSanitizer: 1568 byte(s) leaked in 28 allocation(s).

After (built with EXTRA_CFLAGS="-fsanitize=address"):
  # perf record -e cycles --filter 'period > 1000' -- true
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.024 MB perf.data ]

Reported-by: Namhyung Kim <namhyung@kernel.org>
Closes: https://lore.kernel.org/linux-perf-users/20261020053226.55936-1-namhyung@kernel.org/
Fixes: 56ec9457a4a2 ("perf bpf filter: Implement event sample filtering")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/bpf-filter.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/tools/perf/util/bpf-filter.c b/tools/perf/util/bpf-filter.c
index 72e83ac1d6a4..1596b08fe4e6 100644
--- a/tools/perf/util/bpf-filter.c
+++ b/tools/perf/util/bpf-filter.c
@@ -423,16 +423,8 @@ int perf_bpf_filter__prepare(struct evsel *evsel, struct target *target)
 {
 	int i, x, y, fd, ret;
 	struct sample_filter_bpf *skel = NULL;
-	struct bpf_program *prog;
-	struct bpf_link *link;
 	struct perf_bpf_filter_entry *entry;
 	bool needs_idx_hash = !target__has_cpu(target);
-#if LIBBPF_CURRENT_VERSION_GEQ(1, 7)
-	DECLARE_LIBBPF_OPTS(bpf_perf_event_opts, pe_opts,
-			    .dont_enable = true);
-#else
-	DECLARE_LIBBPF_OPTS(bpf_perf_event_opts, pe_opts);
-#endif
 
 	entry = calloc(MAX_FILTERS, sizeof(*entry));
 	if (entry == NULL)
@@ -501,14 +493,13 @@ int perf_bpf_filter__prepare(struct evsel *evsel, struct target *target)
 		goto err;
 	}
 
-	prog = skel->progs.perf_sample_filter;
+	fd = bpf_program__fd(skel->progs.perf_sample_filter);
 	for (x = 0; x < xyarray__max_x(evsel->core.fd); x++) {
 		for (y = 0; y < xyarray__max_y(evsel->core.fd); y++) {
-			link = bpf_program__attach_perf_event_opts(prog, FD(evsel, x, y),
-								   &pe_opts);
-			if (IS_ERR(link)) {
+			ret = ioctl(FD(evsel, x, y), PERF_EVENT_IOC_SET_BPF, fd);
+			if (ret < 0) {
+				ret = -errno;
 				pr_err("Failed to attach perf sample-filter program\n");
-				ret = PTR_ERR(link);
 				goto err;
 			}
 		}
-- 
2.56.0.212.g129ede20d9-goog

