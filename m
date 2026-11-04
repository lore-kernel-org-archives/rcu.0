Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793811358;
	b=RozCKRmzqwxUsevsUCIbvSw2A11fwLX5xmo7IhkUdvM6htlIrdDhKUJ+eBgYle2Qti5J
	 JQiPBZ8YlahumdzwMzsQ63WftVbo9hvWhl5xucCldhP0Hz1RK0E89byBFQdu84L/uvdYJ
	 pzMISkv6RBZSIgoBTcwH1ctdrvqdeOMZGXqLR14o6NSPzhpfAfvEsTwXihSG71n2zje1d
	 3byP9LUfxcZeBbEZx5oye2iY0wxSvU0Xx2wUMp4uNyRU+y4rkX3dm4TZ/+ee2pVd330pi
	 Kxr0l3a7ror86CL5zf790xodDOGQjTFvmYdUr4Sq1DVsoa1rHSWLy3ZKjlEEI76M9kQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793811358;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=+8KQWyBKBxvk/GyclF/OXvG/qT94C95aX0wcu8sQa/8=;
	b=KeNP6wwT4gboxzHJRRmH7T8TuQL2/HRugNQYiQf9lkRdB1bJf99yNLj0XSVVN9BMJqV1
	 1hjAqdSCjwnQi+8Q85BMJ3jtO+5kveEMugVLe+/ZhWo2y3zB0GygrAVkOvKodhoiDV16e
	 BTYgqDUMlW3x3OP1ndNE05aikwUxvgClMqFauz02ZkX+CylWDeS4M7Lvj18+u1X50cdoy
	 kuyfiiS9rEle+KIuFCzd2V07uj/4o62DtDg1CpIJxmwJXVQoeCn+s08DEp6+WtwJvvxDR
	 zZ0B/nIr69+A6UNdyRJygjDCltAiSu2UCJ+EJVJDuyhEHD8d4483TJdtOuhoGwot4tw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EycCfHSE;
	arc=none smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7A9606A32E
	for <rcu@vger.kernel.org>; Wed,  4 Nov 2026 16:55:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0C7A9606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EycCfHSE
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-35b2c599f43so1894588eec.0
        for <rcu@vger.kernel.org>; Wed, 04 Nov 2026 08:55:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793811357; x=1794416157; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+8KQWyBKBxvk/GyclF/OXvG/qT94C95aX0wcu8sQa/8=;
        b=EycCfHSEmnC3CFQscfhGc9K6l+n6dnpWstzvFxbY/sgIPYFykCn8zDBIa+oXgrvcMa
         lATgPV090nSh34SBkcJD2o5P/IAiOOUJZ9T6EqjWYQwtHFYs3+jJlnP0aSl5YJKnBvsb
         D3HZepsIez9R0xsqvqmbIkK14qdC8qmo1F+tt9+MY4Mgn2c1pNCmzYLqFkK7IcLSP3Ez
         nMiNU6HJ72wXlRUFfjTnzD+XvBK+8GXYnpb8gQh44yzEnH5gO2xIhUy2Ajro6+0/H3a6
         LV4ZNH2ZAQ2mJ/pmbz/77D2ocF1i4FHzguQLCPdF4LogdcdszkoGbHdgKYSUFDWuTs9G
         pCww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793811357; x=1794416157;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+8KQWyBKBxvk/GyclF/OXvG/qT94C95aX0wcu8sQa/8=;
        b=FpIzL7p7YPOoO8abM188uaFSGeOkg0muh/j3jCJEOkiBteQPtmHdNMEeEG/N9AyVnv
         ajbh5Fm7NOTpzRlBx4iRXhwFeWrMspjwJNCYdAERjqv1d60aWGnRqS6syHEj941RmbI3
         qGJtgnELuM6u5PqIN4cO/a5FzFAy0QGTh8MnVijte2Es3lSu3YHV09UlUwQdCllZWXd+
         xvYSU7unHuItQ6ScUo0TWxDwTHb0GnfKnv8veRDmp4V74Sp3RbcjkT6xhokRjax8n1gG
         G7XFEAve7Ls2vJRjEBplxTx2c5oMLB75U0w83PZWAmHc8SxOTqgYfz/UkeArxyjdQ8SH
         I2Bw==
X-Forwarded-Encrypted: i=1; AKwUvBz3N9bKgWy5Q8kV2u3/V+iF6r6kuC0jYhi8EWBN96cwq2dewcsB4dnZi12hg/A0Zwh/lic=@vger.kernel.org
X-Gm-Message-State: APuU4Z8JdAgxpCWDzFwC7Gvbz2SLzv2YWi4cyV09GZILRukVk9fDcbgv
	Ut8+N2U6aMhmmMcC6kRpKVjV3d5UlKic+P0pY2t1TMWJQEfjH8gKGBjy
X-Gm-Gg: AYBFou2nwYX5HIly3u25uN4Kg5bZpet+Gr+JfO9bFiJ3dOc35dDSxVcjQIuQqAnCGY0
	J8mvltQuKfGVM97RyZWFNjn8nhejtgtx8NpnEJR1DAgcRj+N6Q9FD91b0h6BNxTCMrxRbFYk6b4
	byfUfflRJ0VC+gdJlRNT2DZRfOyTAWgggQ13BkiL6OXuYAenplRWNhenh3x3VMHoUkHBgWnAxxW
	o9HYAEw9avZxaVfwSZRkVEo0upNuGMxtDHcG27L+RLhsmmC2MC4LIQVKRQ2EWn8XRar5HNEQHMI
	SwdaVxd0QqNHoLzeGzf2UXJJ9OaF9W1HcVBWYz1M+ScdLkotH/4L4WslGUJJCEXAMMb5o7KIMcM
	kSbgDdDdw1u/ijlimuYX/a+d9JBqn56vKwiFpoSoszx9anGt33Rboyjazk1xxy1t9P+kLTESZzs
	Fh35oPYGlHkRaWs6jaJOkBWD43uchDqwaLucs3z4i0xDVhr+Yen/tQJxbPexdI4hcBDshSCb4wr
	0+vgfLwtkm3D32zUMwdvlfuLjUvgQ9YZJ+ellAI3xKt1Of4XMDNfgEMYUOk6JovlpHtI7tThWif
	is3Off+zYAicIsNRNMqcqkV/HHc8GfPTM79TNwo=
X-Received: by 2002:a05:7301:2a95:b0:36c:9afe:fcd8 with SMTP id 5a478bee46e88-36c9afefe8dmr5108211eec.30.1793811356604;
        Wed, 04 Nov 2026 08:55:56 -0800 (PST)
Received: from kernel.. ([216.195.201.23])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca38d46fcsm9019567eec.13.2026.11.04.08.55.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 08:55:56 -0800 (PST)
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
Subject: [PATCH 04/28] hazptr: Add debug option to force the acquire slow path
Date: Thu,  5 Nov 2026 00:54:22 +0800
Message-ID: <20261104165504.2430480-5-kunwu.chan@gmail.com>
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

Add CONFIG_HAZPTR_ACQUIRE_FORCE_SLOWPATH: makes hazptr_acquire()
skip the per-CPU fast path entirely and enter __hazptr_acquire(),
even when a per-CPU slot is available.  This is useful for testing
slow-path locking, especially with lockdep.  It also lets
hazptrtorture exercise the slow path without requiring the per-CPU
slots to be exhausted.

Note that the forced path skips __hazptr_try_acquire() rather than
running it and discarding its result: a successful try_acquire
publishes the address to the per-CPU slot, and abandoning that
publication would leave a slot pointing at a stale ctx, which
hazptr_note_context_switch() then dereferences (use-after-free).

Suggested-by: Boqun Feng <boqun@kernel.org>
Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
Acked-by: Bradley Morgan <brads@mainlining.org>
---
 include/linux/hazptr.h   |  2 ++
 kernel/rcu/Kconfig.debug | 10 ++++++++++
 2 files changed, 12 insertions(+)

diff --git a/include/linux/hazptr.h b/include/linux/hazptr.h
index 3372b1cdbee6..299ad8a07156 100644
--- a/include/linux/hazptr.h
+++ b/include/linux/hazptr.h
@@ -271,6 +271,8 @@ void *hazptr_acquire(struct hazptr_ctx *ctx, void * const *addr_p)
 	ctx->acquire_cpu = smp_processor_id();
 	ctx->acquire_caller = _THIS_IP_;
 #endif
+	if (IS_ENABLED(CONFIG_HAZPTR_ACQUIRE_FORCE_SLOWPATH))
+		return __hazptr_acquire(ctx, addr_p);
 	addr = __hazptr_try_acquire(ctx, addr_p, slot);
 	if (unlikely(!addr))
 		return __hazptr_acquire(ctx, addr_p);
diff --git a/kernel/rcu/Kconfig.debug b/kernel/rcu/Kconfig.debug
index 7c3c6017b266..3a2e9d7f58f8 100644
--- a/kernel/rcu/Kconfig.debug
+++ b/kernel/rcu/Kconfig.debug
@@ -265,4 +265,14 @@ config HAZPTR_DEBUG
 
 	  Say Y here if you want to enable those assert, N otherwise.
 
+config HAZPTR_ACQUIRE_FORCE_SLOWPATH
+	bool "Force hazard-pointer acquire into the slow path"
+	depends on DEBUG_KERNEL
+	default n
+	help
+	  Make hazptr_acquire() always enter __hazptr_acquire().
+	  This is useful for testing slow-path locking, especially
+	  with lockdep.  It also lets hazptrtorture exercise the slow
+	  path without filling the per-CPU slots.
+
 endmenu # "RCU Debugging"
-- 
2.43.0

