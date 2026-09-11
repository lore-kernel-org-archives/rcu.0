Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012AD3E3156
	for <rcu@vger.kernel.org>; Fri, 11 Sep 2026 03:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789098067; cv=none; b=Z0PGlNlghd3wAsgNDR+6SRmm3A3XRvpDicF/bFkC+ueRYNISz1SQwQfoo730IGDFJq3wvJJYklUZQyv2CCkdfUZmiXSgArb/+BVyFTO6JWENPSvkKiu8Jf1Uqz5E+sJKUr+aXGgQvfZvyfHtbBGzbMP3aDnIjkOOlc/3vA8QkJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789098067; c=relaxed/simple;
	bh=PCjRlXLyzUnojV5TSsYLQGF4tgeA4WOLxoJttOsyuAo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZAFzGoanzGY5dc2qFdrkj985pW5pt8iaOhEv1CDNe8TEtVpw7BIlVXdv7tTfp1ARhbCfwT3gZ8+waB60xXfgYXg7+L9mu76n98AYLBiRZxJ0VwlVcs9zf1SJ+HfByr6HHiDraf4geBqIXbq4/ebYJycu4DnjYhnVyRfUch7dBk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pSdkzsUZ; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pSdkzsUZ"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2dd05e8b98cso3968795ad.3
        for <rcu@vger.kernel.org>; Thu, 10 Sep 2026 20:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789098065; x=1789702865; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nsz3/yKBStl6PSJ3ECifchvs/rkKffL6cy7VoJvWr6U=;
        b=pSdkzsUZhtD+MwRkuLq+pEBv80FYz/OVrqx8k+O5K1iFlfR5hA3aSL6h8NFe27SnBu
         rFra7aRIA4y/1QMYHzXp4ZgNH/ctBzAtUjnW5e3xIOFjZxth5xc51Llijo4MU1WE+IVj
         EShCYsD7ba1NHsKc90p+PMQHZByOn8sOiEMt3cwnu7hN5EFxM3NMKbIDdaVxqgjh5k26
         iijyyHQdboFJbZozu2qByti+XWZym5yNOjQh+WMTk5MK4SBY+aM6O/XLTDtYErno2Alt
         WWIXrUrfGP1B2O5Yq9kcBLE7nG1DecnGBRXcJuXNQgucZ453Jb78ouTHssv8RMTFrbA/
         RD1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789098065; x=1789702865;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nsz3/yKBStl6PSJ3ECifchvs/rkKffL6cy7VoJvWr6U=;
        b=Ww67JtzQUdE4luYOaO3HX8rRDEI6FQcz4qmaaGxpP2Z6HlvNN4IB9c7iGrPT+cuIi4
         txzt8MSvCd3Rhaag+7vOl2O4lvGx0+x8KgZRI9ClSfScUcAycxf/mTK4tbW8sscqXUF3
         N7mhEd9nIcv7XX3g8oG83FLQCRKagqgkMq/c+yV3ep3ygeov209b1P2oWXQgLgPTgSNL
         MRa3hwv+icDu4F7umX8s9sxDLeWLEeCLTws0gqq2gBvPr1hk4Jcy6TzEsTU4wWTQdU8W
         NsFYLDozu4G5SMjNWFlEA1wNj89EJdW8stsG1Ait6/fhcNu8fm3U+Lq5l6zRb96LkVaB
         niUQ==
X-Forwarded-Encrypted: i=1; AKwUvBztsAnNRZbr9gVN4MXPGodzIVcScX9ztt4/VplEXJtrWfVym+kMPTq9EyVEaQ5dBJEg8+E=@vger.kernel.org
X-Gm-Message-State: AFuF++m/iLpe3+GRCZ44GG58un2lk/jOKVl0LxBY+fS9N2J9FAeSAus2
	h2B4gsFHWxb7CBvfxQPy4NaSkOUff4AzJW52izkHABt3RfwFV290YipI
X-Gm-Gg: AYBFou2TIzVfKJym80SdVA429loMOXyJS7dJCRTub/bS8epN0+gJZoB6UGASO5PQAxQ
	Nb6ZisNgA3n7fw4Isx2kqScg7r4G2bkASYT3OVg/3nJGlhS5dv9a4rGJe0HxqZ4/Bm2Jg6crLxc
	jyT3kQCzHXna9GdzeAYvkj7Jx7JfSCzjRHBt18ghPo4MZXkPR8ytEEelK87UawyFtGZSRFrELQX
	jN2QEo5QhfLfPHq29Q/AMH/MYd3+A6RmEw/Tw5DWuW/S5ptsjfcQhUNL/Tjclsq30kxN41e2DZK
	eQV+AqmetiLiNXKl3YTEZp8lwdbHeG3bdq3Dg0S+c7eH3ziRCImp1F/VeGFjCc4R+c2CZvhzhfh
	/Xs7qnKWtDSGxVi1DDGBzf9cr6zWDgu69YBQ7srE3UVYdqHLNM7jtugdAiTUqG98p/KrQkIkpof
	w57hwMLXrL0fmbkLDkftM9Cj9ZHCNjS6+AR2MJpSPJkOxeO+gdrZZa+9LIEeAjcuHJN5J5lozyd
	iznXWeQ7Cc5xuXKKMczLi0VgdeV9LtnUWgUNSGQIIzijhTtiBNbUIjYCnUpmkZjGinKbakQqTWf
	hl/OH2MqTvNXe8it95h/GthBKMYPyTTtRBs1NIkYKTc+ut009m6xoBzpALU7fexRIp3y+xvzqg=
	=
X-Received: by 2002:a17:90a:dfc6:b0:381:1c96:829b with SMTP id 98e67ed59e1d1-39d9bbdedc2mr3577728a91.3.1789098065012;
        Thu, 10 Sep 2026 20:41:05 -0700 (PDT)
Received: from spider.bream-herring.ts.net ([103.252.203.158])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d9afa367bsm558148a91.0.2026.09.10.20.41.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 20:41:04 -0700 (PDT)
From: Matthias Goergens <matthias.goergens@gmail.com>
To: paulmck@kernel.org,
	urezki@gmail.com,
	harry@kernel.org
Cc: frederic@kernel.org,
	neeraj.upadhyay@kernel.org,
	joelagnelf@nvidia.com,
	josh@joshtriplett.org,
	boqun@kernel.org,
	rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	jiangshanlai@gmail.com,
	qiang.zhang@linux.dev,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	rdunlap@infradead.org,
	surenb@google.com,
	vbabka@kernel.org,
	rcu@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/1] rcu: make userspace barrier hook drain kvfree_rcu work
Date: Fri, 11 Sep 2026 11:40:58 +0800
Message-ID: <20260911034059.3569914-1-matthias.goergens@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <6092a9d0-0125-4da4-ac48-85ccaeb83beb@paulmck-laptop>
References: <6092a9d0-0125-4da4-ac48-85ccaeb83beb@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Extend rcutree.do_rcu_barrier to drain kfree_rcu() batches and per-CPU
SLUB sheaves as well as ordinary callbacks. This strengthens the documented
test interface, implementing the follow-up proposed when
kvfree_rcu_barrier() was added in 2024:

  https://lore.kernel.org/all/20240820155935.1167988-1-urezki@gmail.com/

While testing bcachefs performance changes, ktest's /proc/allocinfo check
falsely reported leaks despite repeated hook writes and a 20-second wait.
An earlier prototype let the same unmodified workload pass: eight
checkpoints in one VM, after 50 through 400 option changes, found zero
retained reconcile_scan objects. The original kernel's retained count
eventually fell as a sheaf filled; no unbounded growth or OOM was observed.

Following Paul's v2 review, retain the entry sequence snapshot and check
it after the unconditional kvfree_rcu() drain. If complete, retain smp_mb()
and skip the final ordinary barrier; otherwise, call rcu_barrier(). An
unrelated ordinary barrier cannot justify skipping the deferred-free
drain. The start-rate throttle remains unconditional. The documentation
now scopes completion to work queued before the request, without
preventing new concurrent work.

This can avoid an extra barrier operation: v2's trailing rcu_barrier()
takes a fresh snapshot and need not reuse the internal barrier. No
elapsed-time improvement has been measured.

Exact-v3 builds and interface smoke checks passed in four fresh two-vCPU
TREE_RCU VMs: two with kvfree batching and two with SLUB_TINY (unbatched).
Each completed three true requests, remained idle after false, and
rejected invalid input with EINVAL. Full kernel logs showed no WARN,
oops, panic or RCU-stall diagnostics. The v1/v2 private-cache completion
and ordinary-callback regression tests have not been rerun on v3. These
smoke tests neither prove concurrency/weak-memory correctness nor force
the guarded fallback.

v2:
https://lore.kernel.org/all/20260910170040.344864-1-matthias.goergens@gmail.com/

Matthias Goergens (1):
  rcu: make userspace barrier hook drain kvfree_rcu work

 .../admin-guide/kernel-parameters.txt         |  9 ++++--
 kernel/rcu/tree.c                             | 30 ++++++++++++-------
 2 files changed, 26 insertions(+), 13 deletions(-)

-- 
2.55.0
