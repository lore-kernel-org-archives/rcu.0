Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9D62D978C
	for <rcu@vger.kernel.org>; Mon,  9 Mar 2026 19:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773084674; cv=none; b=uNbMEO9A0RqDzvyNm1iom2e8dtyPwGfzaXeqgSNBIF/Tw8GMSrze8GMm0Oe9nhG/C+kA+GOOkwayhx6ErOS1Ed6vdlJmfgH7xihLTVcgK8nS9DVZO/rGkYlT7V+Nzf+1+Z0bRhhxaMWnqMFxBoGh4jnUKX/+FJlEMtAX90iLAk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773084674; c=relaxed/simple;
	bh=iW/ovbydh6oe8AnccpxkXTU0eghC5tS6m7BQI/qh4ik=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=VL344KxyXNX8vYFBur4FIG4cxhOwWquHbQIbkDvIclgLI+/LyJakRJJylvJLCQPP6YKDt5O/xaiH8iLWv5nDdvq6TOiDS/wbD4hSFp8LsuO0+iMvZmtTIZF4Lcq4wIW1xHS//Jb4CN+i+aA9CqKR79HrPLQeQYJnjef7kYqbCEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=usO9sazn; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="usO9sazn"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-829b8bb5173so665362b3a.3
        for <rcu@vger.kernel.org>; Mon, 09 Mar 2026 12:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773084672; x=1773689472; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s7IWN2tD4stFfXobSZdPZ2dyLMJvR8FtsJ70ojQYFj0=;
        b=usO9saznJYUdXgvFh0wddzDKO4/XLuQKVqibQfEnkhy79eL2IvRO7tBdRYpf+N44Ej
         JyEk4Qxx+Dk8UBtjnS50nHBh5VmxfpdoVogaQYsS2g/K6sLlX4Iokr65vM2ZZVv05FDD
         we2EYtuKmeJAVr6Q3kblV1VXYnYRI8phZwrpJmQOA4v05eOZ8bkRfVsgi3Q8SqoYb65G
         t2JQ1vCOs/Y+49OfNR3OrBd+GD2HOyrtPcKNqh+O1Zx5OyjiZUbRMR8LnhoFXjgqD7Yr
         0qX/83pcLWSTmo3kV7/lHCXWuFlYEMF/IFyJQWLpcKBe4gOak9Ip+Z2W+YzNShzn3ir8
         lKiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773084672; x=1773689472;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s7IWN2tD4stFfXobSZdPZ2dyLMJvR8FtsJ70ojQYFj0=;
        b=Q0vAfgp+wUXpx+uFuPth1jnbX6IaWbheHXTiZyZQuuhmW+5As75ledolNwVCj/GfD4
         ThENeW2JD+8uAJDPHNkSYQOnVfBdZ77BQbtuP148Xrk12mmS4CPMI7WzEUtQV6GWmGea
         Fo+xKLrQoRhEp/Hv4wXW8MrSDyRBKT+bviJn/T1T9jJ6JtXera5qXodf2uuePZza/T7k
         rqUnYNHkEAm7eFU0fjqv82utciC2ZTEtL1YmbxdqTlbBLb/HMZXCbrhJce06saxk3Qqo
         Wyi+2MKAjILk4pJbWzoGyLix0ikJRDKORYxofgiu0EQxjWxRfhlK+eMxkIQlhjIlddoF
         iZSw==
X-Gm-Message-State: AOJu0YxLGZ+gROT0H/DTuohmT/dv07kAAsWdAg/ySoneH/90plAQkTo8
	3Ll9ytSHJXZ81Wp0GVX69GjayhN7qCG58tjwSo1jHb/938sxT3DhwzEsdEohs0FB8voVBxJB/Tm
	ysp2EyA==
X-Received: from pfbjc7.prod.google.com ([2002:a05:6a00:6c87:b0:829:7d34:ff91])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2e23:b0:81f:48d4:a979
 with SMTP id d2e1a72fcca58-829a30a6273mr10762158b3a.49.1773084672132; Mon, 09
 Mar 2026 12:31:12 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Mon,  9 Mar 2026 12:30:56 -0700
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260309193059.2244645-1-seanjc@google.com>
Subject: [RFC PATCH 0/3] srcu: KVM: Add, export and use call_srcu_expedited()
From: Sean Christopherson <seanjc@google.com>
To: Lai Jiangshan <jiangshanlai@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Josh Triplett <josh@joshtriplett.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc: rcu@vger.kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sean Christopherson <seanjc@google.com>, Nikita Kalyazin <kalyazin@amazon.com>, Keir Fraser <keirf@google.com>
Content-Type: text/plain; charset="UTF-8"

We've got a conundrum in KVM where we have multiple use cases that generally
want the same thing (eliminate waiting on guest configuration changes whenever
possible), but use KVM uAPIs in slightly different ways and effectively create
competing requirements.

The crux of the problem is that one use case wants KVM to free an object via
call_srcu() so that the task doesn't risk getting stalled waiting for a grace
period.  But for the other use case, using call_srcu() can trigger a
non-expedited grace period and cause a synchronize_srcu_expedited() in a
different ioctl (that must do a full sync, i.e. can't use call_srcu()) to stall
waiting for the non-expedited grace period.

Tagged RFC because while having the call_srcu() request do an expedited grace
period eliminates the unwanted synchronize_srcu_expedited() stalls, this feels
like a very crude fix.   That said, I'm definitely not opposed to this being a
final solution if it's the best option available.

Sean Christopherson (3):
  srcu: Declare exported symbols before including srcu{tiny,tree}.h
  srcu: Add and export call_srcu_expedited() to avoid transferring grace
    periods
  KVM: Expedite SRCU callbacks when freeing objects during I/O bus
    registration

 include/linux/srcu.h     | 10 +++++-----
 include/linux/srcutiny.h |  8 ++++++--
 include/linux/srcutree.h |  2 ++
 kernel/rcu/srcutree.c    |  7 +++++++
 virt/kvm/kvm_main.c      |  2 +-
 5 files changed, 21 insertions(+), 8 deletions(-)


base-commit: 5128b972fb2801ad9aca54d990a75611ab5283a9
-- 
2.53.0.473.g4a7958ca14-goog

