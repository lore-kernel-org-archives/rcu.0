Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793811496;
	b=sEAw+8J9hkMGgtYXXcMZ+o7Ku9xUzNbfobZE5MXSCDC+Lg6NKEXfhGisixTRO1Cl0e/x
	 2MEHndCimpcN51ywsYVHinyTlWQ4Bf612EsE0Xn9XgXwCr7Any9r5zHsbnS02BLeoOv2T
	 IbZIVRF5M1kCRrjF4xi9kbYISO+Q/GL5KMa609HUyrnp1FZaSdo9KWkqEu/8E9nsILhFg
	 koPxlzNtfhWrliER754cNzKyOMCiM6/2utBwdB8WIVMnQxxp/yWIuJNp4jk6U9Kwc4L1g
	 IkmuTbBSIer5645BsHl760tZGnxRnZMqVGQ/J8+jxF8wQpcQ2fkfn1XQKAFDstvUzrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793811496;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Y7w9zIZGwFreJVwPOaTuHd6p4ZAf4hMC78IhCBOO/FI=;
	b=ZlFyFAIkA+vne7jm7pmc1yS+pNmy7kaCVCxTiZouumhrhGM+tUpeP/8KexyHIGPLJAsS
	 iotNYdI0iPLJb1h6sLVS94Xf+pdi0IpFoSIzH8OOStjdcVGD1yNmTODnZDFsGE1FmIvPe
	 Lbyz6ldFozYoRyb2p7VJ5KzKwIzAlbm3Vq2WnNVQ268xJTrcfzqIMqvpRTqZZoy3NJqWy
	 hX+WxHljitZWYM04HRyApVVGFh8JZ4tNnQZsOX/8xEYiPezz0NxGaEsm2Ea+OzdupS9c9
	 KidveQTJEW285kdHZTkKtBicC6ZMljcsI7uhkFCbeoyE/+Ay4Ayi2rGwaloS6eDE/zA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hNr3tUus;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B663606D827
	for <rcu@vger.kernel.org>; Wed,  4 Nov 2026 16:58:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3B663606D827
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hNr3tUus
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-36cad25b8b0so1364249eec.1
        for <rcu@vger.kernel.org>; Wed, 04 Nov 2026 08:58:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793811495; x=1794416295; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Y7w9zIZGwFreJVwPOaTuHd6p4ZAf4hMC78IhCBOO/FI=;
        b=hNr3tUusaaErjUitu2I6XbppO/tHcSXKdcNOfa5cTRenOkzbAShzlYf+Vh6lhhHcnU
         tV0j2CjmKzhKKOb88naSBWlsm7UMSz+rFmaMbHHVVo52UBAQUQqzpBCnbhekDTbeMHdu
         m2HGm/OC5cbaC5EsFBwb01g0ztwO9qcrVtWW/Gy5r5WiqyNKkT4Fnrid+ZtOZGerKzfs
         i5yhjeAtyPa/dnKRefMUtTmhyXApUGDjfd1Rt/xYYyIFeKFYslG1vZ7fTtcF5bzZh99e
         yUQCBLmrELZusND1vAwkU7lxXMR4LlihbNcRhxjtalepwnGQ6X6xc8qKK1tJvFak4VpN
         STow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793811495; x=1794416295;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Y7w9zIZGwFreJVwPOaTuHd6p4ZAf4hMC78IhCBOO/FI=;
        b=kbO3mGpJAneDLUAnWtg5eu5x+oU6/AeSKPPntVZPNqPT8fkRhsZdLbJItQyv6ideZX
         i1c41Q4+C3tT5pva36RNEQBxDDK2295Y/M0RWXjG6/hMOkAzJzZoE8wBdNl9OQZpg8M2
         d+BkvpkufEU6Wnv9ol0Tw4CgYhgevm9kCT6QcXHOlPlinAVFIe0VKonpscwotYDaajWi
         EMTDNd3C276oxXN1k9EpzSB3jKh6QJK5lBSy7w7vr3a33W9P/ON3c2MbhEbwTIWK9MYk
         BJS6OVaPM60x2RqJ5S2M+k1MXh/9ZiT5qniVWwR9jv5GmvI6810Ktb/qdfMkem/qP82K
         sGog==
X-Forwarded-Encrypted: i=1; AKwUvBwPFIIbIdFPGiP9Hja8jX92EprPnm+yCmwOMvRxcpGDAm1DVjPeTYGLJ9AJGjTlZae0UkQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z+zx04awA3aBPkhUYdRVmPBikECg31MXOA323Yz5AJ1cuE1GL4f
	QkvNYYwVElSiw2OccwINNs5qMKIHkAORcBNHsb+tL4IRDEDGfrtm3/Td
X-Gm-Gg: AYBFou04nqnViy8rrJhNBAxXde+EJzUK79npnL7+Q3dfcmLtVygpXLrkyXnNyviWhPU
	YZ4cVZxJk8Io/dX2P9Y1vNb+SKSgj61qQfGy/CxXGEzn2sxGHhX/6d4AW4Hv0+PJhZRsWpcVPzf
	UV6GLOzgTjZ9qQOU9PB/DQYfYazgFV5ghFHlBe+GrGDCmXFOzT+Gz3mFdISyswyxFJgUHaoEB69
	Rr+gCa41R9gjSRl02qOVXCBvqFlgDfwDk3dXVTGhswOAQlKMdARJa1N4SdzRtdzdxP24BI1plEQ
	a6cZpEQStLjU1JNIsSsUBCdzMtJoKEsTvr6t0JBoFk1902UuABiVCwBBUcC3W5MBaAvyJPeqmNC
	ocTEUk7QC4Pg287DPdQFC/bSQf+/kIkzor6d3eE0UVbv406eXlzH8wlqgyNw5HbgZiyPcYS9AjG
	XkmF1MS/uxFWeY0j+yedItkC8SD7zvBPcOPOhvgpQBrD21hDDWYgSnN3z9MBWIajRfofypBwURk
	lFrcNDGObV0mIriQaw9yi3otjO3vsiMKB3zafFIW8UP+XKKkgMi7uhpomEf8rwCt7IKU6bvsML+
	Px3MIRCqjy5KdCvOzhAUTmow8h0lTA0ivSMavec=
X-Received: by 2002:a05:7301:fc81:b0:36c:d29e:668f with SMTP id 5a478bee46e88-36cd29e694cmr3306314eec.6.1793811494826;
        Wed, 04 Nov 2026 08:58:14 -0800 (PST)
Received: from kernel.. ([216.195.201.23])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca38d46fcsm9019567eec.13.2026.11.04.08.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 08:58:14 -0800 (PST)
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
Subject: [PATCH 19/28] Documentation/litmus-tests: Add hazptr drain generation-visibility test
Date: Thu,  5 Nov 2026 00:54:37 +0800
Message-ID: <20261104165504.2430480-20-kunwu.chan@gmail.com>
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

Prove that the drain engage's smp_mb() publication ordering is
correct: a release hook that observes the new drain address also
observes the new generation counter (herd7: Never).

Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
---
 Documentation/litmus-tests/README             |  4 ++
 .../hazptr-drain-generation-visibility.litmus | 41 +++++++++++++++++++
 2 files changed, 45 insertions(+)
 create mode 100644 Documentation/litmus-tests/hazptr/hazptr-drain-generation-visibility.litmus

diff --git a/Documentation/litmus-tests/README b/Documentation/litmus-tests/README
index 604c2c0025d9..79b0634ddb13 100644
--- a/Documentation/litmus-tests/README
+++ b/Documentation/litmus-tests/README
@@ -123,3 +123,7 @@ hazptr-drain-resnapshot-slot-race.litmus
 hazptr-drain-safety.litmus
     Test the engage snapshot race: the engage can miss an in-flight
     slow-path acquire, so completion must defer on wildcards.
+
+hazptr-drain-generation-visibility.litmus
+    Test the drain generation ordering: a release hook that observes
+    the new drain address also observes the new generation.
diff --git a/Documentation/litmus-tests/hazptr/hazptr-drain-generation-visibility.litmus b/Documentation/litmus-tests/hazptr/hazptr-drain-generation-visibility.litmus
new file mode 100644
index 000000000000..d5c1ca247d71
--- /dev/null
+++ b/Documentation/litmus-tests/hazptr/hazptr-drain-generation-visibility.litmus
@@ -0,0 +1,41 @@
+C hazptr-drain-generation-visibility
+
+(*
+ * Result: Never
+ *
+ * Drain generation visibility: the engage publishes the
+ * generation counter before the drain address (separated by
+ * smp_mb()).  The release hook reads the address with
+ * smp_load_acquire().  If it observes the new address, the
+ * subsequent generation read must also observe the new value,
+ * so the cmpxchg compares against the correct round.
+ *
+ * If this were not the case, a release could read a stale
+ * generation (from the previous drain round) while the address
+ * already belongs to the new round, causing the cmpxchg to
+ * succeed against the wrong round's marker and falsely
+ * decrement the new round's backup_outstanding.
+ *)
+
+{
+	gen = 5;
+	addr = 0;
+}
+
+P0(int *gen, int *addr)
+{
+	WRITE_ONCE(*gen, 6);
+	smp_mb();
+	WRITE_ONCE(*addr, 1);
+}
+
+P1(int *addr, int *gen)
+{
+	int r0;
+	int r1;
+
+	r0 = smp_load_acquire(addr);
+	r1 = READ_ONCE(*gen);
+}
+
+exists (1:r0=1 /\ 1:r1=5)
\ No newline at end of file
-- 
2.43.0

