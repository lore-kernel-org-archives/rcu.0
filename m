Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102741EB37
	for <rcu@vger.kernel.org>; Mon,  1 Apr 2024 22:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712010583; cv=none; b=pHvXCvT4MGYxrXIpMWjfeta/lZuMvbZ0p3h0qYcADiQxq6dXVwhJNULaBMwEQBGVmmmk+1xgVUmDhSzNJQMAX+EciMqjZQNL3F14O3N6X2KxdQzBYdUXllCMHi41ROl2ruPb9kiFV1ATNNpyc777OrV9Tz9xTVoCDOdi+dtFQMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712010583; c=relaxed/simple;
	bh=uRf1QBahqZS8Z955x72vM5aZgORLckJbANqvbX6mN9A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CpM+wigZ3Es779EajqdoCyXUEfMMTfDAnMDMK+MWaXklJhda43v/VVoiXZsoNpd1nflUaEp/1TO1Tan1usdbh4tjl0YCR7RgkSFDj8TaJU+EHy8UTuOWANmAq+ykHEwdwDdlIeBd2i0zheQGbLvJyB+603vxmLA5kf4cD2jDV9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eyJbGAh0; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eyJbGAh0"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61510f72bb3so9416107b3.0
        for <rcu@vger.kernel.org>; Mon, 01 Apr 2024 15:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712010580; x=1712615380; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dxbv2zR344az1ZpGGMLXWBIEjEGxYRekW2mxLE4Y23k=;
        b=eyJbGAh0iBdRTIwMI4OtvSBqKQoDFg8NJ0Ep0pbIoQM4UVBLdB+08muoCbmzO0irzt
         vMLd2qxkSYhzgMbqjXOPsYAfCv6KsjCPt50iAmogxnZ55hxu+sWNoRxuKrQz7qk5KXbY
         xd8ehcUj5hymmgHqFksAHhoYb8JyrVuMxfIxLyif2Kw9rIoNnkGStYSc/41R1Nmlz3P6
         xCGGqBbjPdRaKiYL3zLyYPsh/lvAlGUB+iq1/nabr0gicxOJMQJ2YcGfAOYfO6Xs9C83
         YLnx80yRuicS13u4vTP4/LV6Yb9ni169DPe/1YHhZM9Z7TvZ+iU22QWmVMRezUa+OBr4
         eIyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712010580; x=1712615380;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dxbv2zR344az1ZpGGMLXWBIEjEGxYRekW2mxLE4Y23k=;
        b=JA22YF+LJ2F+JycWPVay08o1W14MXbUfeKjdt0NDYQKXbylAUF8u4aCP9kY1jUEbHA
         kpBk7LxwXuS2OEECD1uOzLauTOdvBs5aiAvCGhSM6frM/En1tvL7bvOP92NolxPHbd0P
         WUXmbdVyG7dUFTi460vuep8jXIHE/hha/uurYyhQVJSTDeObdUUns0Twff1FEgdebTs+
         IBkkrdw8/ojiVsD1X+2Kh6SW9MqAungyUHkuMzsF7Tkl8+dlH6jGDF0W8TplbFjrJXws
         CRo4BxSce1EyaeaBMhvA94CBvWgLqwyjDI+xb+W3sfFWlas83A/T+GQJYIEB90aBLjN0
         xL1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWvWWu48hjfrVU26JdV9lUDdpzf3sbMflQkzwejDQJ8kB+Q1Fz4nvxY96X2VpefFNNKrAEUdvlxENL5vNT0q1zsCmEv
X-Gm-Message-State: AOJu0YzKq3Vo5k4yz8svqckrwy29sfqBp95Ykg4vrIKwYBm1e44lWNp+
	zB8c0kq+rhZ22CAFlhElU81v+Hdf0+imHNXlu0XDeleSF5lRP3oniTqSi0pizZbqhMaud5i7vX3
	BVA==
X-Google-Smtp-Source: AGHT+IHEvNGnR/FEXAGvVteLDZwjTiunaD1N2L6JusyGM6kOld5osvQPso1tIa1rejLfUzGR7x2twBKIPo4=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a0d:e202:0:b0:615:1579:8660 with SMTP id
 l2-20020a0de202000000b0061515798660mr246209ywe.7.1712010580188; Mon, 01 Apr
 2024 15:29:40 -0700 (PDT)
Date: Mon, 1 Apr 2024 15:29:38 -0700
In-Reply-To: <ZgDyxpaf+HgQzYDp@chao-email>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240309010929.1403984-1-seanjc@google.com> <20240309010929.1403984-6-seanjc@google.com>
 <ZgDyxpaf+HgQzYDp@chao-email>
Message-ID: <Zgs1Ul2rZjyUvMEx@google.com>
Subject: Re: [PATCH 5/5] KVM: VMX: Always honor guest PAT on CPUs that support self-snoop
From: Sean Christopherson <seanjc@google.com>
To: Chao Gao <chao.gao@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Josh Triplett <josh@joshtriplett.org>, kvm@vger.kernel.org, 
	rcu@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Kevin Tian <kevin.tian@intel.com>, Yan Zhao <yan.y.zhao@intel.com>, 
	Yiwei Zhang <zzyiwei@google.com>
Content-Type: text/plain; charset="us-ascii"

On Mon, Mar 25, 2024, Chao Gao wrote:
> On Fri, Mar 08, 2024 at 05:09:29PM -0800, Sean Christopherson wrote:
> >Unconditionally honor guest PAT on CPUs that support self-snoop, as
> >Intel has confirmed that CPUs that support self-snoop always snoop caches
> >and store buffers.  I.e. CPUs with self-snoop maintain cache coherency
> >even in the presence of aliased memtypes, thus there is no need to trust
> >the guest behaves and only honor PAT as a last resort, as KVM does today.
> >
> >Honoring guest PAT is desirable for use cases where the guest has access
> >to non-coherent DMA _without_ bouncing through VFIO, e.g. when a virtual
> >(mediated, for all intents and purposes) GPU is exposed to the guest, along
> >with buffers that are consumed directly by the physical GPU, i.e. which
> >can't be proxied by the host to ensure writes from the guest are performed
> >with the correct memory type for the GPU.

...

> > int kvm_tdp_page_fault(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
> >diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> >index 17a8e4fdf9c4..5dc4c24ae203 100644
> >--- a/arch/x86/kvm/vmx/vmx.c
> >+++ b/arch/x86/kvm/vmx/vmx.c
> >@@ -7605,11 +7605,13 @@ static u8 vmx_get_mt_mask(struct kvm_vcpu *vcpu, gfn_t gfn, bool is_mmio)
> > 
> > 	/*
> > 	 * Force WB and ignore guest PAT if the VM does NOT have a non-coherent
> >-	 * device attached.  Letting the guest control memory types on Intel
> >-	 * CPUs may result in unexpected behavior, and so KVM's ABI is to trust
> >-	 * the guest to behave only as a last resort.
> >+	 * device attached and the CPU doesn't support self-snoop.  Letting the
> >+	 * guest control memory types on Intel CPUs without self-snoop may
> >+	 * result in unexpected behavior, and so KVM's (historical) ABI is to
> >+	 * trust the guest to behave only as a last resort.
> > 	 */
> >-	if (!kvm_arch_has_noncoherent_dma(vcpu->kvm))
> >+	if (!static_cpu_has(X86_FEATURE_SELFSNOOP) &&
> >+	    !kvm_arch_has_noncoherent_dma(vcpu->kvm))
> > 		return (MTRR_TYPE_WRBACK << VMX_EPT_MT_EPTE_SHIFT) | VMX_EPT_IPAT_BIT;
> 
> W/ this change, guests w/o pass-thru devices can also access UC memory. Locking
> UC memory leads to bus lock. So, guests w/o pass-thru devices can potentially
> launch DOS attacks on other CPUs on host. isn't it a problem?

Guests can already trigger bus locks with atomic accesses that split cache lines.
And SPR adds bus lock detection.  So practically speaking, I'm pretty sure ICX is
the only CPU where anything close to a novel attack is possible.  And FWIW, such
an attack is already possible on AMD.
