Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9EA51DFE3
	for <rcu@vger.kernel.org>; Sat,  9 Mar 2024 01:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709946587; cv=none; b=OYVmD3Me0eFgsG+ajovSAQOEMQSaHfBOMC2ufP9s2OK78jgsIW84a2ANsjnUjU/xzZIySnmeXvP8Azt85roJDXjW4ofvrSfZ7VkLttFFxpkoVcuxs0BExQGs7OVuw1nIyfpzCoCkEMVz2iEm5QTAN5caKwKUCRVXGO8hiksURSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709946587; c=relaxed/simple;
	bh=ycBchpSWHJX8l3+qZZZs50c8pkvQnvrnnxo1fe2hEZc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HuA7ZyIW9utiMq3YGul1FR2LoGpvxskNx9FGLZj++YJW0pBi7rxJ272NFEdCRVOtulliRRKLewO+2tr/R7/CZfAaTQdqeP3tKEiIb4MNatldkj8moKunKnBkp2GNkEqZkd3MT4JEm/bjoG33qEPccMUH60kO+o0o9h/rftyBG3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2FT3jFrK; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2FT3jFrK"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-609ff5727f9so22500327b3.0
        for <rcu@vger.kernel.org>; Fri, 08 Mar 2024 17:09:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709946585; x=1710551385; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=g4owpzTMykQxDUqiA6ej7g45orHQxXd/2WL2dIWa35k=;
        b=2FT3jFrKAA7AuyqS+TGTMp9MsPHqm7nfNdjH2gI2DxkC+nmlNDEui/eS9thJOX3L5S
         AzMQ3rFqqzsW2L7qbBnund07mHDuaEKVjKrvkYPDHCZXG0ur10H3cnx9atKyDG3p1MgU
         tqvTarwQn0JLdGbaxq8kQyeUpzT1VeJQZJiRFWgNca0pp10U63YKD0HWAnTCWX1w7YTb
         F9DEM4vZmuJ/sM/Q+Xk9GimlRSMfphtZQt5tJhFx5z4an4zE9fMBWPSYNP8SgYEN39s0
         M7c/AbD+IijsH9oKNgd5nl8BpE7xcDg6qtDMYzwvW7/ZF6D39eBgg8UiKfaARAtWLOr0
         g0NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709946585; x=1710551385;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g4owpzTMykQxDUqiA6ej7g45orHQxXd/2WL2dIWa35k=;
        b=FXOsYHdBBgTOv1h76nCGmOkJoo94iL/z+tUIf9rlO9JJ6rvmEh4GF1jB97vEt+EFXI
         nV3dzc/oCnKS6yV7GUBo6Y8fIyfMKj2eUhH4wcTI7g7GM79iQnfLd0lbRM6EK5UJ6nQ8
         Zrkpb3EG0YHytnC4/HSTMlm/WSGajcNZvnpJD39xbiAxm8BHzKsy+2upJ0gnl20MTvIw
         2x0EGf6JgmQeGBFl+xonviOoLSmvBqsI/cSjNrOXzhkrDy+dWLt7bjGfzyXhpHVH8le2
         W8RaNgTlx/hcx6MiOcEGnk9C1pw9G9th1UcqG0apO+Zgs2rM9tQsLtWt9ktT3Fbx1vR6
         hfhA==
X-Forwarded-Encrypted: i=1; AJvYcCVMZjsOOSrFmhgRChrTG1ng3iLnDMIpoFW0tOFy8d+VWwkFIPiggiKkF7s/ymJW1ljjvKja70fYVLmpS3n+J5WFbhtT
X-Gm-Message-State: AOJu0Yzwl7LqhxoQvDA903w3QeB3GZCEA9uBzOokWN/XJAzUL6AuNBC1
	PUZNcYZ3RI+55iVROQQEtL+WUq0JDmn4WvKtG56N9zuTsD3Bu/jRA5Y9X3tCKs06wKOZPDiX4Za
	eRQ==
X-Google-Smtp-Source: AGHT+IG6WhzVfQfNxhkh6vO1oFttllHBGIxq53Aa6SsBcpq2DPCtMuTS0yWAgaYlxw31FNSJQ8BASJ/xVnw=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a0d:df93:0:b0:609:6150:da22 with SMTP id
 i141-20020a0ddf93000000b006096150da22mr217869ywe.1.1709946585045; Fri, 08 Mar
 2024 17:09:45 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  8 Mar 2024 17:09:27 -0800
In-Reply-To: <20240309010929.1403984-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240309010929.1403984-1-seanjc@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240309010929.1403984-4-seanjc@google.com>
Subject: [PATCH 3/5] srcu: Add an API for a memory barrier after SRCU read lock
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Josh Triplett <josh@joshtriplett.org>
Cc: kvm@vger.kernel.org, rcu@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Kevin Tian <kevin.tian@intel.com>, Yan Zhao <yan.y.zhao@intel.com>, 
	Yiwei Zhang <zzyiwei@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Yan Zhao <yan.y.zhao@intel.com>

To avoid redundant memory barriers, add smp_mb__after_srcu_read_lock() to
pair with smp_mb__after_srcu_read_unlock() for use in paths that need to
emit a memory barrier, but already do srcu_read_lock(), which includes a
full memory barrier.  Provide an API, e.g. as opposed to having callers
document the behavior via a comment, as the full memory barrier provided
by srcu_read_lock() is an implementation detail that shouldn't bleed into
random subsystems.

KVM will use smp_mb__after_srcu_read_lock() in it's VM-Exit path to ensure
a memory barrier is emitted, which is necessary to ensure correctness of
mixed memory types on CPUs that support self-snoop.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Sean Christopherson <seanjc@google.com>
Cc: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
[sean: massage changelog]
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 include/linux/srcu.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/linux/srcu.h b/include/linux/srcu.h
index 236610e4a8fa..1cb4527076de 100644
--- a/include/linux/srcu.h
+++ b/include/linux/srcu.h
@@ -343,6 +343,20 @@ static inline void smp_mb__after_srcu_read_unlock(void)
 	/* __srcu_read_unlock has smp_mb() internally so nothing to do here. */
 }
 
+/**
+ * smp_mb__after_srcu_read_lock - ensure full ordering after srcu_read_lock
+ *
+ * Converts the preceding srcu_read_lock into a two-way memory barrier.
+ *
+ * Call this after srcu_read_lock, to guarantee that all memory operations
+ * that occur after smp_mb__after_srcu_read_lock will appear to happen after
+ * the preceding srcu_read_lock.
+ */
+static inline void smp_mb__after_srcu_read_lock(void)
+{
+	/* __srcu_read_lock has smp_mb() internally so nothing to do here. */
+}
+
 DEFINE_LOCK_GUARD_1(srcu, struct srcu_struct,
 		    _T->idx = srcu_read_lock(_T->lock),
 		    srcu_read_unlock(_T->lock, _T->idx),
-- 
2.44.0.278.ge034bb2e1d-goog

