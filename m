Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793811405;
	b=MhRPjKIL00Ahy/PuUQSxSXZ8+OeUQJXh/fNBgfgV5K2EROjNke4Hh+p4IvVtCYcLkruS
	 DoujhSHdRcjNmng/DjIEhO53DPV4R/jMP89uhWc04I06K38xbGTtVI0I2BoXv5o/VIaPr
	 bRZGd9WdJVRnCzgWruru6YJ+1oX0fnWZOal+dYIn97g2zIir0wqs4BCpEnWVNCgkcCOCS
	 aBgDvbPicgukRRPywL0yyeZQDNZA4zAzFxtMi5DwhYnM7pyoBH3OOisunj8LU+C3YnLcD
	 bdWLtYZ5o7Rw0uB/4RCEEnqIHACEq+34BeGph3eCpWwX/HCDNmeDeXvasdsrr6/NjFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793811405;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=QREUsxQO+WlzAGZqj6P+b11EFcbYycJK2BqXbXpSFQw=;
	b=f+sxXEUEvU+BdLPhb1fm8f6xLb1r32zz1jtvp6dH8ogXtE8EWRoHiNobUGI31L4ZO7EE
	 OEWorTHdEItOl7uaKk/32G3iDiybzWktGvRjApoWIOA7oAmelDZEl8R4pJiIRoR2Q4Gol
	 5S36eKzjiUBjkILU1CTtHQW7775GpeqvRtP5aBtrRs49MUFKrkprGlMPIuzFgtTc6gPd7
	 KUfCt15bWWWsjgZTrnyLs+nGDTZgD8ChqlawjmB/oSB/wWHhPqXGO0LMW5Qcg0YvmKxxP
	 NCirr1wHkPKoNNBn5+SKlP7i0cr6XVEjZgRhH2TEqUatM/3ZwkUlFI6ok69VWcwMGDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fE8WH1MK;
	arc=none smtp.remote-ip=74.125.82.181
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08733606A33F
	for <rcu@vger.kernel.org>; Wed,  4 Nov 2026 16:56:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 08733606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fE8WH1MK
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-3550c917fd3so1341686eec.0
        for <rcu@vger.kernel.org>; Wed, 04 Nov 2026 08:56:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793811403; x=1794416203; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QREUsxQO+WlzAGZqj6P+b11EFcbYycJK2BqXbXpSFQw=;
        b=fE8WH1MKci4/tbOVBnJedYZrGTpUWQYU6L/1iUfnHKTUHhPapsG5ksuKHGAOT0+Bul
         d/z+dGRxCJ6aamcS0zzHgcwDJ4MdPZWqjDLr2gnttF6MZhzB2QHkR7BVrMWu+yuGWJGQ
         IxhmUZCVKxbCWS2ZDY2bXZq0SMCPMiZpxg7n3hu/lOfaAvfXIKTrbdcgrBS9ZfFUVPPU
         dce4azDrVK9nu70VUB9+o0C/rGPtu3O0JwvR2EbeLw1mVBViSDmD3QruVjqeIPbbKtma
         8ZQ/vQ4iY4whe4/9hwWcx6tOOnyEubAyxtgnmfbAuvrSlFsSucoq5Qgv+UgLhx9So5Da
         E1rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793811403; x=1794416203;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QREUsxQO+WlzAGZqj6P+b11EFcbYycJK2BqXbXpSFQw=;
        b=XHf61rbeND64Ln8baDUgfuq7KVTCaIzIx9hfuE5s8tpVMNBmRjd9xCD/rtEQmCWZxL
         X/0PsmaZeYONSEERIbgkU5uzd1hmodUv3pbm3vqrnLE9TrEPnqnMikE7lRvlQe9g7Vx6
         sCHMfsaEERKVrE5tK17iWlJTZlzMCMXVvH1+BGrKynIobr8woR+GtAR8mYMJJ8BOx+wP
         lycLPVO7HmV1LF1azS72JoUp6uObmsoxQV63synxmvonM9faDpuYTzDR53gEv11+PDJ9
         ymzxx8B4XxIVPUW6lpc9yRb6xVPq39sIu6YstwL3aZW/RZEpIHzqdp9gT6YfDOC/az1u
         fo7A==
X-Forwarded-Encrypted: i=1; AKwUvBztXm7TG9jgKKbb68NH7Z18p9c+Yz0UTOuyFd1vsh6H2LWRX0X2ahznCfg7f4qT+ZkOiCo=@vger.kernel.org
X-Gm-Message-State: APuU4Z8vJPreLd+OrP86QwQc23i/yVEB6Gx0ztEYNRw9YauiFfbQRcd6
	rCXNBzm3YLqW3Zm6Ea+1AqNuSdvB59meA+uxR48nYHNkCpDq3OXkXLUc
X-Gm-Gg: AYBFou1oz0d9wTnOFhBkkZVhuY5W9cPtXALlEIJ54vrRESakW8aO/0w1kRjYKC/zlVj
	Rmdip1cNhKloY/2d3QtJlZq7t2OmzAYVrQsSNXhwovetuIvgMMn9RjhokAsTu5G+zMJd+kx173f
	QFVOFqGbewaLM8WzW5z9+5JygmRU73wtUKy6bgqQXL14mgPaXsWyCxoHDNf6WWcbyfCb2iUbfY8
	j3frZTY6s0ZRCUXplh0k6rjJ7mSvu/lzJpAh4NJq3qHKrZDus2U6TWN192dDVel0kLFwYIbOHIV
	HJxkxri7vBG0viVbmrHqHG3VsUtU67mFfuFKwQO0zOfM1ORE5FIxmCHfeQX8W1hBX8OOmX5d/F0
	PT7Dt5SBWXPs1GxNHEacD9GyhSd8ood3E6iqB8/8ihRc4/yjsJ39kbgd4+UsQ4Ksevsodh+qwv0
	Ap0dUauDPMGkCECHTuGUuO7pIlHbaOUMF8iwqg/ZScsu+CTr1luWYz6YioTpRkGURPWJzOZVGRG
	VldhUHd5eR41lF5+eEk1SHDhROjjkNyKLicv8iatPgBmb0LEzhiAC9IWNNiMXT2GApNfazgj8jK
	GDImeM/GeheU5tO8mQr3mkZdGPasal3uLUWkLdw=
X-Received: by 2002:a05:693c:41d9:20b0:368:4acb:f8a with SMTP id 5a478bee46e88-36a4242f5fdmr24794481eec.17.1793811402488;
        Wed, 04 Nov 2026 08:56:42 -0800 (PST)
Received: from kernel.. ([216.195.201.23])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca38d46fcsm9019567eec.13.2026.11.04.08.56.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 08:56:41 -0800 (PST)
From: Kunwu Chan <kunwu.chan@gmail.com>
To: paulmck@kernel.org,
	boqun@kernel.org,
	mathieu.desnoyers@efficios.com,
	jiangshanlai@gmail.com,
	corbet@lwn.net,
	mingo@redhat.com,
	frederic@kernel.org,
	neeraj.upadhyay@kernel.org,
	josh@joshtriplett.org,
	urezki@gmail.com,
	dave@stgolabs.net
Cc: stern@rowland.harvard.edu,
	parri.andrea@gmail.com,
	will@kernel.org,
	dhowells@redhat.com,
	j.alglave@ucl.ac.uk,
	luc.maranget@inria.fr,
	akiyks@gmail.com,
	dlustig@nvidia.com,
	joelagnelf@nvidia.com,
	skhan@linuxfoundation.org,
	rdunlap@infradead.org,
	longman@redhat.com,
	rostedt@goodmis.org,
	qiang.zhang@linux.dev,
	kunwu.chan@gmail.com,
	brads@mainlining.org,
	linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	lkmm@lists.linux.dev,
	linux-doc@vger.kernel.org,
	rcu@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 09/28] hazptrtorture: Add READERS4 and READERS0 torture configs
Date: Thu,  5 Nov 2026 00:54:27 +0800
Message-ID: <20261104165504.2430480-10-kunwu.chan@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261104165504.2430480-1-kunwu.chan@gmail.com>
References: <20261104165504.2430480-1-kunwu.chan@gmail.com>
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add READERS4 and READERS0 configs to cover reader-active and
reader-free synchronize paths.

Both use the PREEMPT baseline and hazptr-stack torture type,
with four readers for READERS4 and no readers for READERS0.

Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
Acked-by: Bradley Morgan <brads@mainlining.org>
---
 .../selftests/rcutorture/configs/hazptr/READERS0 | 16 ++++++++++++++++
 .../rcutorture/configs/hazptr/READERS0.boot      |  2 ++
 .../selftests/rcutorture/configs/hazptr/READERS4 | 16 ++++++++++++++++
 .../rcutorture/configs/hazptr/READERS4.boot      |  2 ++
 4 files changed, 36 insertions(+)
 create mode 100644 tools/testing/selftests/rcutorture/configs/hazptr/READERS0
 create mode 100644 tools/testing/selftests/rcutorture/configs/hazptr/READERS0.boot
 create mode 100644 tools/testing/selftests/rcutorture/configs/hazptr/READERS4
 create mode 100644 tools/testing/selftests/rcutorture/configs/hazptr/READERS4.boot

diff --git a/tools/testing/selftests/rcutorture/configs/hazptr/READERS0 b/tools/testing/selftests/rcutorture/configs/hazptr/READERS0
new file mode 100644
index 000000000000..c5b12f3bef74
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/configs/hazptr/READERS0
@@ -0,0 +1,16 @@
+CONFIG_SMP=y
+CONFIG_NR_CPUS=16
+CONFIG_PREEMPT_NONE=n
+CONFIG_PREEMPT_VOLUNTARY=n
+CONFIG_PREEMPT=y
+CONFIG_HZ_PERIODIC=n
+CONFIG_NO_HZ_IDLE=y
+CONFIG_NO_HZ_FULL=n
+CONFIG_HOTPLUG_CPU=y
+CONFIG_SUSPEND=n
+CONFIG_HIBERNATION=n
+CONFIG_DEBUG_LOCK_ALLOC=n
+CONFIG_PROVE_LOCKING=n
+CONFIG_DEBUG_OBJECTS_RCU_HEAD=n
+CONFIG_DEBUG_KERNEL=y
+CONFIG_HAZPTR_DEBUG=y
diff --git a/tools/testing/selftests/rcutorture/configs/hazptr/READERS0.boot b/tools/testing/selftests/rcutorture/configs/hazptr/READERS0.boot
new file mode 100644
index 000000000000..f5564c218902
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/configs/hazptr/READERS0.boot
@@ -0,0 +1,2 @@
+hazptrtorture.nreaders=0
+hazptrtorture.torture_type=hazptr-stack
diff --git a/tools/testing/selftests/rcutorture/configs/hazptr/READERS4 b/tools/testing/selftests/rcutorture/configs/hazptr/READERS4
new file mode 100644
index 000000000000..c5b12f3bef74
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/configs/hazptr/READERS4
@@ -0,0 +1,16 @@
+CONFIG_SMP=y
+CONFIG_NR_CPUS=16
+CONFIG_PREEMPT_NONE=n
+CONFIG_PREEMPT_VOLUNTARY=n
+CONFIG_PREEMPT=y
+CONFIG_HZ_PERIODIC=n
+CONFIG_NO_HZ_IDLE=y
+CONFIG_NO_HZ_FULL=n
+CONFIG_HOTPLUG_CPU=y
+CONFIG_SUSPEND=n
+CONFIG_HIBERNATION=n
+CONFIG_DEBUG_LOCK_ALLOC=n
+CONFIG_PROVE_LOCKING=n
+CONFIG_DEBUG_OBJECTS_RCU_HEAD=n
+CONFIG_DEBUG_KERNEL=y
+CONFIG_HAZPTR_DEBUG=y
diff --git a/tools/testing/selftests/rcutorture/configs/hazptr/READERS4.boot b/tools/testing/selftests/rcutorture/configs/hazptr/READERS4.boot
new file mode 100644
index 000000000000..0d0df3f7dca4
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/configs/hazptr/READERS4.boot
@@ -0,0 +1,2 @@
+hazptrtorture.nreaders=4
+hazptrtorture.torture_type=hazptr-stack
-- 
2.43.0

