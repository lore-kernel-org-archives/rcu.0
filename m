Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683BC71727
	for <rcu@vger.kernel.org>; Thu, 14 Mar 2024 14:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710427680; cv=none; b=ePH8O+Rr0+vdzyKXbWHe9Al90Ocyq2r5rHXb3qZv+FQHRIPpi96rmeWgdr5g9yj5zi9NjSBEQNIdvf+HEbXx00PShiwiQk37Unc3vUQvSGp1m1j0NR8gYL7J9iFIChFdPcX1jIotf85c/FfNFriqrkFmXPTWRjpFGPjlFYQ3TLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710427680; c=relaxed/simple;
	bh=o8GtUI7JCR1UlHN2Jj7OLRVxrCmqhcWR9eQX21BsIY0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BcrAUHqljNZv6TrJWKkLY5jWljHELqPJe7g1MH10Z0XxRgQn1ORn1jo/okaois9dMno+tAgbdG0PJWFgSsn3IcMJ9fP5FFmEodSiKxb+ekfubIkLBsULuxMwwHTOzNqPgtmMrThbRJNsZF1+V8QCr7nDgRQEcA3Fc0B6yiCT9yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L4BnZfR4; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L4BnZfR4"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-6e6b55ae0c2so1063918b3a.1
        for <rcu@vger.kernel.org>; Thu, 14 Mar 2024 07:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710427679; x=1711032479; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UCLtGcT112yIVdDhvDfaxSfuuQ/aEnwbhFAj1Y1MJlw=;
        b=L4BnZfR47Qlt94yHryz6Xj3xsgDwbIB64vQogZFwiE4/ZqXqRPJHHRFv6E2+Qp7k8E
         UqUzs2dLr6WLQPtoXKash8SGD+b/9pZn4WSwTDhe2ssYaUPCR60Hx8plCcHE+Ub9/tU2
         qPiB5uVXuC/szoR/i4p1XXDs6IMw/BkxcYHA8B3imypY2pJu2t0qAogrK8Z/IN5C+u9q
         SVu1/UVcYFXxWzLuPEESMo98Vtt9tJuOyRUHtGxOQdk0LrtGpUUq4CkEdWD+nrkD5W37
         WpBqoi0Jxl5F3XF97c9jwlCR1fA2+mH7glIekoCkZejbFJ2amsa28ozuY3LaQhsIKGNF
         EVJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710427679; x=1711032479;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UCLtGcT112yIVdDhvDfaxSfuuQ/aEnwbhFAj1Y1MJlw=;
        b=CfFJN6oJKC3+CfOtOvguwSA5SOLyQGvyU+4X4M2qKaJPy4H6VVcmPUatsjp3uCATAe
         BReltH0dcrW+fT0Fm+eytdCvAUsgzpFiZUeA8sS/defT7Sw6S/332h9D1MqasSCv87fT
         rn80CwLAaaBMkvR4knE+MT7BhZDs0DVpaxmPu7o7cy9jyxX8d49oZyuRG+Lhr2i7PXGj
         Kj+EqQWGKR53iYDAdIW7iwotXtim4a4f0axWN+r+wpf4w9lyQCWhja+iybJUWQltFFtR
         vu1odxwk0pJJKnMOBzKjOn+MJ3omwxcDm5tU53Oy0p/f/GCT8T7c6I/UNxX7VodsTe2T
         Dp/A==
X-Forwarded-Encrypted: i=1; AJvYcCXSYCaQdjRmUjp0WCS6ssqalTeF/H9ApCLWmKNYAGj6f3j6E8Wd9Eq55IxMc8E8kypDNCBExtHA6nSZDQeYzBD8EhdU
X-Gm-Message-State: AOJu0YzO7RwQ/DeIcF4wq/9Vqf0IkoS9bgspxepVP6j8ShPLzNaUDlTh
	SDqHS2BIKkIK04Uk/s1BDITGI7Yp6O+KXfN26HUv6gQLXtRhHjASTytsVScshgLkUocg20Lgl9D
	UQg==
X-Google-Smtp-Source: AGHT+IFUARZWuJkNnGfTumcikVFdmjDQIP3ztgYAXM+CX00BY4XnJfbYnor2ZYJyZWzlUdnMVYU7RQpjNs8=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:3d15:b0:6e6:b638:3f78 with SMTP id
 lo21-20020a056a003d1500b006e6b6383f78mr86525pfb.5.1710427678684; Thu, 14 Mar
 2024 07:47:58 -0700 (PDT)
Date: Thu, 14 Mar 2024 07:47:57 -0700
In-Reply-To: <73c670d1-0301-49bf-472c-97ae8d1b6c7c@oracle.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240309010929.1403984-1-seanjc@google.com> <20240309010929.1403984-2-seanjc@google.com>
 <5ee34382-b45b-2069-ea33-ef58acacaa79@oracle.com> <ZfCL8mCmmEx5wGwv@google.com>
 <73c670d1-0301-49bf-472c-97ae8d1b6c7c@oracle.com>
Message-ID: <ZfMOHSTHXoPxP6v8@google.com>
Subject: Re: [PATCH 1/5] KVM: x86: Remove VMX support for virtualizing guest
 MTRR memtypes
From: Sean Christopherson <seanjc@google.com>
To: Dongli Zhang <dongli.zhang@oracle.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Josh Triplett <josh@joshtriplett.org>, kvm@vger.kernel.org, 
	rcu@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Kevin Tian <kevin.tian@intel.com>, Yan Zhao <yan.y.zhao@intel.com>, 
	Yiwei Zhang <zzyiwei@google.com>
Content-Type: text/plain; charset="us-ascii"

On Thu, Mar 14, 2024, Dongli Zhang wrote:
> On 3/12/24 10:08, Sean Christopherson wrote:
> > On Mon, Mar 11, 2024, Dongli Zhang wrote:
> >> Since it is also controlled by other cases, e.g., kvm_arch_has_noncoherent_dma()
> >> at vmx_get_mt_mask(), it can be 'may_honor_guest_pat' too?
> >>
> >> Therefore, why not directly use 'shadow_memtype_mask' (without the API), or some
> >> naming like "ept_enabled_for_hardware".
> > 
> > Again, after this series, KVM will *always* honor guest PAT for CPUs with self-snoop,
> > i.e. KVM will *never* ignore guest PAT.  But for CPUs without self-snoop (or with
> > errata), KVM conditionally honors/ignores guest PAT.
> > 
> >> Even with the code from PATCH 5/5, we still have high chance that VM has
> >> non-coherent DMA?
> > 
> > I don't follow.  On CPUs with self-snoop, whether or not the VM has non-coherent
> > DMA (from VFIO!) is irrelevant.  If the CPU has self-snoop, then KVM can safely
> > honor guest PAT at all times.
> 
> 
> Thank you very much for the explanation.
> 
> According to my understanding of the explanation (after this series):
> 
> 1. When static_cpu_has(X86_FEATURE_SELFSNOOP) == true, it is 100% to "honor
> guest PAT".

Yes.

> 2. When static_cpu_has(X86_FEATURE_SELFSNOOP) == false (and
> shadow_memtype_mask), although only 50% chance (depending on where there is
> non-coherent DMA), at least now it is NOT 100% (to honor guest PAT) any longer.

Yes, though I wouldn't assign a percent probability to the non-coherent DMA case.

> Due to the fact it is not 100% (to honor guest PAT) any longer, there starts the
> trend (from 100% to 50%) to "ignore guest PAT", that is:
> kvm_mmu_may_ignore_guest_pat().

Yep.
