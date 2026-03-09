Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6EDC40F8D9
	for <rcu@vger.kernel.org>; Mon,  9 Mar 2026 19:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773084677; cv=none; b=lKWGaiCVXHoEA+aH1VcjSAsCviO8BvVsKdv7sRlKNJhmHf06cgrxniGHFmzodaq//TZU4hrZaKNUYdoQDJ2/uIZ/lGKpNH5Ee0/tBcam4mk+9jdu4aHWAYu0FWvGZCgJOWytf7YwAAIn8R9mP7DSiCwWqSkzrTlPgto0jGRJvVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773084677; c=relaxed/simple;
	bh=zqSouceZtFC5TpkGpy+KiFus4h62hOvNb+G9ZODiRYE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fl6T1qMmlOZSxaODphbyLr4hrEA7Av/8xFZonZwylWvMX03b3q+U7tgDSI455vGKrE96Wo1a/FVFdvdJhw0jAH4/DWTYGH6BYiSQXtjgI+1JT2I9IcRqnQLk67m98E9uwTddEDVnDSXjko51kNGDhBqwFL4Jb6Zd/hl9+ERz9S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XUgzOMyp; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XUgzOMyp"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2ae42659a39so523274325ad.1
        for <rcu@vger.kernel.org>; Mon, 09 Mar 2026 12:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773084674; x=1773689474; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=wblNA6bj3f7w06PD/nTLmV/SuffW2mSGdWVBXF9Y8dI=;
        b=XUgzOMyp9Y1oN6fXRl22p6JHmy+Xk/0x9JJMz5aNgNrg+0pZAzkdJhdZsLswx6n5JD
         ciR4DVH6f4KR6mMlag6337uQsGjHDcGmcEtv/GvO9B9yvCj5MrUS6JDPZ37lI0Fkmmir
         wX8bMRkP4t+3Il56No5JdzJMxuKv5MWXfqu4R8t53MJ5f/pESOzRwkfvTabK7WdYBu1d
         WcKbWcr4u+FHYuLs/zV6DMOOAuWOlYx5l6lw/5+vLwLnpYT/JUJ/IETPlA/NQStMviGE
         JbEHh7ZDbsx/TSGttOlv/lUtV8hPCgo6sblYdZDRBWMMAIc+EBLPle/VpeqylZr7jlmq
         RVmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773084674; x=1773689474;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wblNA6bj3f7w06PD/nTLmV/SuffW2mSGdWVBXF9Y8dI=;
        b=PCVLVulFqwmfIiNxAG5t28rEjkD8lev/z9mhFksLnGnveNh290WkeXs9tMaIZGk/j9
         5yWxophM9zSKIGCaiyRJ9Yjspwt6ijg5TbGjSeruZhw5LpKFed0UiWkr/H19nPpljLdg
         8WlK3ucrsGYj0VmX9tJWn1ph471aWwZwbP0ITEf/VtvlT6idjpLqz9kM7cX4VdZjAfd6
         PzeV7azTlxQii3maCA0JcECfSsvuf6qzNzlfYZixCmBH1iqtd16tQByj8wLb6t0fU3Zi
         NzVUl4PozqQiXDq2N+CE4g1oSNyIme3L7Pf3KKwliMGxC6JoWSJozcHt09JvZyp4scuw
         nTpg==
X-Gm-Message-State: AOJu0Yzwu8DTIgEB1QATJdVVXY/byOwzcLcwREyDSxL/u67dBBTegM6r
	qg43gxizBfDT4Liqr+G7I4n/1FdaN/CCjqI9gqltiMFKbot9Z3IHE4EzvpG4aIxnWip3GbMQdv7
	3atGV/Q==
X-Received: from plcy10.prod.google.com ([2002:a17:903:10a:b0:2ae:45a4:ca9f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2b06:b0:2ae:50ec:fa2e
 with SMTP id d9443c01a7336-2ae823a1f61mr121594565ad.21.1773084674028; Mon, 09
 Mar 2026 12:31:14 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Mon,  9 Mar 2026 12:30:57 -0700
In-Reply-To: <20260309193059.2244645-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260309193059.2244645-1-seanjc@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260309193059.2244645-2-seanjc@google.com>
Subject: [RFC PATCH 1/3] srcu: Declare exported symbols before including srcu{tiny,tree}.h
From: Sean Christopherson <seanjc@google.com>
To: Lai Jiangshan <jiangshanlai@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Josh Triplett <josh@joshtriplett.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc: rcu@vger.kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sean Christopherson <seanjc@google.com>, Nikita Kalyazin <kalyazin@amazon.com>, Keir Fraser <keirf@google.com>
Content-Type: text/plain; charset="UTF-8"

Move the declarations of call_srcu(), cleanup_srcu_struct(), and
synchronize_srcu() above the inclusion of the implementation specific SRCU
header so that tiny SRCU can provide inline wrappers, e.g. for expedited
versions, without needing to re-declare synchronize_srcu() and call_srcu().

Opportunsitically use rcu_callback_t in the call_srcu() declaration instead
of an open coded equivalent (all implementations already use
rcu_callback_t).

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 include/linux/srcu.h     | 10 +++++-----
 include/linux/srcutiny.h |  2 --
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/include/linux/srcu.h b/include/linux/srcu.h
index bb44a0bd7696..1cbc37e3b59c 100644
--- a/include/linux/srcu.h
+++ b/include/linux/srcu.h
@@ -79,6 +79,11 @@ int init_srcu_struct_fast_updown(struct srcu_struct *ssp);
 						// instead of smp_mb().
 void __srcu_read_unlock(struct srcu_struct *ssp, int idx) __releases_shared(ssp);
 
+void call_srcu(struct srcu_struct *ssp, struct rcu_head *head,
+	       rcu_callback_t func);
+void cleanup_srcu_struct(struct srcu_struct *ssp);
+void synchronize_srcu(struct srcu_struct *ssp);
+
 #ifdef CONFIG_TINY_SRCU
 #include <linux/srcutiny.h>
 #elif defined(CONFIG_TREE_SRCU)
@@ -87,11 +92,6 @@ void __srcu_read_unlock(struct srcu_struct *ssp, int idx) __releases_shared(ssp)
 #error "Unknown SRCU implementation specified to kernel configuration"
 #endif
 
-void call_srcu(struct srcu_struct *ssp, struct rcu_head *head,
-		void (*func)(struct rcu_head *head));
-void cleanup_srcu_struct(struct srcu_struct *ssp);
-void synchronize_srcu(struct srcu_struct *ssp);
-
 #define SRCU_GET_STATE_COMPLETED 0x1
 
 /**
diff --git a/include/linux/srcutiny.h b/include/linux/srcutiny.h
index dec7cbe015aa..4976536e8b28 100644
--- a/include/linux/srcutiny.h
+++ b/include/linux/srcutiny.h
@@ -64,8 +64,6 @@ struct srcu_usage { };
 #define init_srcu_struct_fast_updown init_srcu_struct
 #endif // #ifndef CONFIG_DEBUG_LOCK_ALLOC
 
-void synchronize_srcu(struct srcu_struct *ssp);
-
 /*
  * Counts the new reader in the appropriate per-CPU element of the
  * srcu_struct.  Can be invoked from irq/bh handlers, but the matching
-- 
2.53.0.473.g4a7958ca14-goog

