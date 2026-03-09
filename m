Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8344F411615
	for <rcu@vger.kernel.org>; Mon,  9 Mar 2026 19:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773084679; cv=none; b=u7w/0KcF10SUt3ZRZpLD3OcVIWrp+BptNYXEWgR2b008+l2BjGJSXvbnxJNrQZWRNV6d6OTLdR+zLgMVF04qYAYzqB21R/QCYgOjkzrBtXj+sqt7mkjQ5++oG2aISrquSsQCp2fsFUwYK3QJAEqpp52ZrmOOvpN5iGHNUKeFEHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773084679; c=relaxed/simple;
	bh=Nh7tJ/pXL5Y8LgZgxu8ghrpxcPTqp2B/CPbh/N2FO2o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AIxjD4xKkw9V4WsSZhEQND6c2QMfL7A7D1dL5WzXTy5IZz+YO08lAvVKlGSDxWTaTrZ55/bddUyxNr9MC6slCv5zZgBkZZPp28Owtni1jUfSuV+QvB/5vqSvrZSSAR6I6HbY6KwluN6unDIMbo4m1yuZWFBoYV15vYmIKUr6kcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=T8OOh4Xp; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T8OOh4Xp"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c738bebd53fso16182539a12.3
        for <rcu@vger.kernel.org>; Mon, 09 Mar 2026 12:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773084678; x=1773689478; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=dwTNwSVWtekPolaPxHcXxrp4YHsI9DpDNNtRgjqHJNI=;
        b=T8OOh4XplhQwITKtupHWbpHnO9AipUvoIybVxEjI8yMS05fUcYk3dUt2Wn3nKuDYPr
         NwMv/6ehPFXa5pTb4Mjx8cVRpejXZElS3/blRbM21LFNEE6tJ52K0HdBfKMvgqZV3WvI
         byqS5d/Q4Cgx+0u/AKKUuxXc6bqikgfVOUCWC83WMRjCuU+yQ9W0XC5ji80FW0BbJcvd
         9coVuRAR7u/uoBD8tpBGlxyYOq9Dwak42M2fNLZpF9wPee57q1779Q/BIVeDkQ9S9HxD
         ifiXyv0QFGcaKNr3PxgeLbpAbPR8VV3V2BLCG1976Pl224nL73WTtTl9sV/6Iquj129x
         8nng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773084678; x=1773689478;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dwTNwSVWtekPolaPxHcXxrp4YHsI9DpDNNtRgjqHJNI=;
        b=oyd8HhBuRd7HP5OBmM30l0xExVfVWvFNEYd8wZS3BrO6WFfkVnHe42zFCPBdD1TwEK
         AfV9j+t9I3lgQvGbpnjnvV7sD2n3LpnIMdOoYEavmUHj5GyBLC0FNj5QCXbpZHjZcV6F
         eQU0Zw7UgsxTSL8+tXYPzurQ+SPuBM/eytlpyBI4KOzMXKO98Yqkf+UGrY0kbfvK4shH
         HzIMwFhJasjKQrUo0c1DsFuARq9Mazzcv9Fr4MTrzBHMHliC5hTU5l5Jm+LUiRTR8MTS
         QeV+Dye7rf6ZEyIVSkOTvagcJF4PPACYVtA29QZhlGEyhkr3p3uBEMPvA3ZCF71NGsZX
         NYHg==
X-Gm-Message-State: AOJu0Yydpv/FcYjgt2BM5A21pjSFwkketdNRfoa2UcNWE0fZSvLbRzbB
	KkXxcGodM+s08CMU3kzT63iyoHgWLC53uRaaXJo8hU8HTUMSekKIjb14lqqLuvZpXXkZIbrVixF
	Tni6zUA==
X-Received: from pgbfq28.prod.google.com ([2002:a05:6a02:299c:b0:c6e:1ddf:c9ec])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:549f:b0:398:78cb:d85
 with SMTP id adf61e73a8af0-39878cb252emr6354695637.13.1773084677666; Mon, 09
 Mar 2026 12:31:17 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Mon,  9 Mar 2026 12:30:59 -0700
In-Reply-To: <20260309193059.2244645-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260309193059.2244645-1-seanjc@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260309193059.2244645-4-seanjc@google.com>
Subject: [RFC PATCH 3/3] KVM: Expedite SRCU callbacks when freeing objects
 during I/O bus registration
From: Sean Christopherson <seanjc@google.com>
To: Lai Jiangshan <jiangshanlai@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Josh Triplett <josh@joshtriplett.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc: rcu@vger.kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sean Christopherson <seanjc@google.com>, Nikita Kalyazin <kalyazin@amazon.com>, Keir Fraser <keirf@google.com>
Content-Type: text/plain; charset="UTF-8"

Use the recently introduced call_srcu_expedited() when freeing the old I/O
bug during device registration to avoid triggering a non-expedited grace
period.  Delaying the freeing of the object by a full grace period is a
complete non-issue, but the grace period also gets transferred to future
synchronizations, e.g. to the synchronize_srcu_expedited() invocation in
kvm_swap_active_memslots().

For micro-VM use cases, effectively transferring the non-expedited grace
period to memslot updates results in a meaningful delay in overall boot
time.  E.g. with a CONFIG_HZ=100 kernel, the sync triggers a ~20ms delay,
increasing boot times by 15% or more.

Fixes: 7d9a0273c459 ("KVM: Avoid synchronize_srcu() in kvm_io_bus_register_dev()")
Reported-by: Nikita Kalyazin <kalyazin@amazon.com>
Closes: https://lore.kernel.org/all/a84ddba8-12da-489a-9dd1-ccdf7451a1ba@amazon.com
Cc: Keir Fraser <keirf@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 virt/kvm/kvm_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 9faf70ccae7a..ceaf08a03428 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -6021,7 +6021,7 @@ int kvm_io_bus_register_dev(struct kvm *kvm, enum kvm_bus bus_idx, gpa_t addr,
 	memcpy(new_bus->range + i + 1, bus->range + i,
 		(bus->dev_count - i) * sizeof(struct kvm_io_range));
 	rcu_assign_pointer(kvm->buses[bus_idx], new_bus);
-	call_srcu(&kvm->srcu, &bus->rcu, __free_bus);
+	call_srcu_expedited(&kvm->srcu, &bus->rcu, __free_bus);
 
 	return 0;
 }
-- 
2.53.0.473.g4a7958ca14-goog

