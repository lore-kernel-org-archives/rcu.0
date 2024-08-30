Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5D616D4CB
	for <rcu@vger.kernel.org>; Fri, 30 Aug 2024 09:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725010542; cv=none; b=omakUDWedjY/SB+PAo0r3EGa+7YRV7af3X/Q++ncnpYFFgkYFyyOVsSJ9pnfkc2/xejZGCwqXG8hmSYDCq6w2ufN0Q4lHKxVXGriOeUZl9Qf1qOm5P41nzjqNnpH1sB7zRBJrLzeMAOdYyRx4Gr07Ww4IaNR8ovDWBVpGfjxuLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725010542; c=relaxed/simple;
	bh=/4AcU+5mrCpQ2UoZHnX2vYZ7xGUajTi/DEYXF9Kh1RQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=T66sgcNdpp06tZgmzK0DP/ALUpM0EVU3P0b9FpBZkturkQLeD0+ZhtOw0nAMKzxnh82PP3lGyg3ml/f6IX7Kv7hHgKcFnjopyDcqvY1FvfQ23Q6cUJKOHhd3hIPp/voOOCjG5Dy27CohmdLtExx/86lun/zfFzy3WmNGnQ6c/0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CZC/DR/M; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CZC/DR/M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725010539;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gOLHpXbrDu4AZVBfm8LLHD5ogMcE5R5Aph6RTHz3h88=;
	b=CZC/DR/M7nKW5w5hlTieihh8xLsbPoq+cm1K0UX0c3JwVTC25eM4faVlwRkbUrM+HAc+pD
	9I7B/LXastpQqIFxWns1tmOPLb8qQ4l9Pj4DSjQQQKXBtJPjYrgi/IC/zpFHkOzuWgmu63
	lozDLKZOkg7Up+/XSIuXHPutNQo3rMk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-KR1UVH2UOeWjBu-SDYCmcQ-1; Fri, 30 Aug 2024 05:35:35 -0400
X-MC-Unique: KR1UVH2UOeWjBu-SDYCmcQ-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-42bbe908365so1643155e9.2
        for <rcu@vger.kernel.org>; Fri, 30 Aug 2024 02:35:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725010534; x=1725615334;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gOLHpXbrDu4AZVBfm8LLHD5ogMcE5R5Aph6RTHz3h88=;
        b=r4hfGr/7ecyXI6VW5q64G0KdJ0P24fG2qHR1M6WZgetSN+JSCREhvc9GIswvFOuikQ
         DaLOq3olE8zDjhjA1ge1K79t2LHUb+cFr23f0kboofFBUD/pVCBxhSrSqZ0AMW4wyZG7
         hWdMTUYxGgeugsT7b79ypKhIRr1DRCH7GPluQjVbx/TwRPnmyra8FjSv4o/63xQhLy3z
         gGLGBX3L4bHlLyFH58X3i3bzKMkpjX15R2uEMBWypKTa6Sn2aOnwFi4XXByb1w3gXTqP
         qKC3luIh8yOYsakaQ5gkpq5Hk+e3Jp3vv7G/IleeihU5FWCAxkdgFBPR8vbcg0uo7E/f
         M/3w==
X-Forwarded-Encrypted: i=1; AJvYcCWRNXC4q+1BJLWig3tnAlst2uHU9jnf7+Acr3VA1/WtT88kVv5VZPJzBg5Dob2Fmh6RGeQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZtuQ+auDUYQAry5PD62Y7DSxfHONB288PBu5pwWS7zqtafBFQ
	IybdELPCdco6V5Qtw5CU9DizQXSYBuv/18Hf9ikRFZHRK/JXOCt6kXfVlHQrFkdjwSskw+1cXl7
	zEmaLF1C1R7+BW/NSKi+fE/UTbYEt0gSfOrDTo4UPKjGVj5lZWA==
X-Received: by 2002:a05:600c:4f42:b0:427:9a8f:9717 with SMTP id 5b1f17b1804b1-42bb0137641mr48082385e9.0.1725010534366;
        Fri, 30 Aug 2024 02:35:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFAXdxCbGrEOrDzUMeJDkQaCX59o438yNucxDqSfAGGWzdvpKi8o3/65PT380tdrco4sEffaA==
X-Received: by 2002:a05:600c:4f42:b0:427:9a8f:9717 with SMTP id 5b1f17b1804b1-42bb0137641mr48082115e9.0.1725010533790;
        Fri, 30 Aug 2024 02:35:33 -0700 (PDT)
Received: from fedora (g2.ign.cz. [91.219.240.8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bb6df0a0asm40473115e9.13.2024.08.30.02.35.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 02:35:33 -0700 (PDT)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
 <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
 Kevin Tian <kevin.tian@intel.com>, Yan Zhao <yan.y.zhao@intel.com>, Yiwei
 Zhang <zzyiwei@google.com>, Lai Jiangshan <jiangshanlai@gmail.com>, "Paul
 E. McKenney" <paulmck@kernel.org>, Josh Triplett <josh@joshtriplett.org>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH 5/5] KVM: VMX: Always honor guest PAT on CPUs that
 support self-snoop
In-Reply-To: <20240309010929.1403984-6-seanjc@google.com>
References: <20240309010929.1403984-1-seanjc@google.com>
 <20240309010929.1403984-6-seanjc@google.com>
Date: Fri, 30 Aug 2024 11:35:32 +0200
Message-ID: <877cbyuzdn.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Sean Christopherson <seanjc@google.com> writes:

> Unconditionally honor guest PAT on CPUs that support self-snoop, as
> Intel has confirmed that CPUs that support self-snoop always snoop caches
> and store buffers.  I.e. CPUs with self-snoop maintain cache coherency
> even in the presence of aliased memtypes, thus there is no need to trust
> the guest behaves and only honor PAT as a last resort, as KVM does today.
>
> Honoring guest PAT is desirable for use cases where the guest has access
> to non-coherent DMA _without_ bouncing through VFIO, e.g. when a virtual
> (mediated, for all intents and purposes) GPU is exposed to the guest, along
> with buffers that are consumed directly by the physical GPU, i.e. which
> can't be proxied by the host to ensure writes from the guest are performed
> with the correct memory type for the GPU.
>
> Cc: Yiwei Zhang <zzyiwei@google.com>
> Suggested-by: Yan Zhao <yan.y.zhao@intel.com>
> Suggested-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/kvm/mmu/mmu.c |  8 +++++---
>  arch/x86/kvm/vmx/vmx.c | 10 ++++++----
>  2 files changed, 11 insertions(+), 7 deletions(-)
>
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 403cd8f914cd..7fa514830628 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -4622,14 +4622,16 @@ static int kvm_tdp_mmu_page_fault(struct kvm_vcpu *vcpu,
>  bool kvm_mmu_may_ignore_guest_pat(void)
>  {
>  	/*
> -	 * When EPT is enabled (shadow_memtype_mask is non-zero), and the VM
> +	 * When EPT is enabled (shadow_memtype_mask is non-zero), the CPU does
> +	 * not support self-snoop (or is affected by an erratum), and the VM
>  	 * has non-coherent DMA (DMA doesn't snoop CPU caches), KVM's ABI is to
>  	 * honor the memtype from the guest's PAT so that guest accesses to
>  	 * memory that is DMA'd aren't cached against the guest's wishes.  As a
>  	 * result, KVM _may_ ignore guest PAT, whereas without non-coherent DMA,
> -	 * KVM _always_ ignores guest PAT (when EPT is enabled).
> +	 * KVM _always_ ignores or honors guest PAT, i.e. doesn't toggle SPTE
> +	 * bits in response to non-coherent device (un)registration.
>  	 */
> -	return shadow_memtype_mask;
> +	return !static_cpu_has(X86_FEATURE_SELFSNOOP) && shadow_memtype_mask;
>  }
>  
>  int kvm_tdp_page_fault(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 17a8e4fdf9c4..5dc4c24ae203 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -7605,11 +7605,13 @@ static u8 vmx_get_mt_mask(struct kvm_vcpu *vcpu, gfn_t gfn, bool is_mmio)
>  
>  	/*
>  	 * Force WB and ignore guest PAT if the VM does NOT have a non-coherent
> -	 * device attached.  Letting the guest control memory types on Intel
> -	 * CPUs may result in unexpected behavior, and so KVM's ABI is to trust
> -	 * the guest to behave only as a last resort.
> +	 * device attached and the CPU doesn't support self-snoop.  Letting the
> +	 * guest control memory types on Intel CPUs without self-snoop may
> +	 * result in unexpected behavior, and so KVM's (historical) ABI is to
> +	 * trust the guest to behave only as a last resort.
>  	 */
> -	if (!kvm_arch_has_noncoherent_dma(vcpu->kvm))
> +	if (!static_cpu_has(X86_FEATURE_SELFSNOOP) &&
> +	    !kvm_arch_has_noncoherent_dma(vcpu->kvm))
>  		return (MTRR_TYPE_WRBACK << VMX_EPT_MT_EPTE_SHIFT) | VMX_EPT_IPAT_BIT;
>  
>  	return (MTRR_TYPE_WRBACK << VMX_EPT_MT_EPTE_SHIFT);

Necroposting!

Turns out that this change broke "bochs-display" driver in QEMU even
when the guest is modern (don't ask me 'who the hell uses bochs for
modern guests', it was basically a configuration error :-). E.g:

$ qemu-kvm -name c10s -nodefaults -smp 4 -machine
q35,smm=on,accel=kvm,kernel-irqchip=split -global
driver=cfi.pflash01,property=secure,value=on -cpu host -drive
id=drive_image2,if=none,snapshot=off,aio=threads,cache=none,format=qcow2,file=/var/lib/libvirt/images/c10s.qcow2
-device virtio-blk-pci,id=image2,drive=drive_image2,bootindex=3,bus=pcie.0,addr=0x8
-drive file=/usr/share/OVMF/OVMF_CODE.secboot.fd,if=pflash,format=raw,readonly=on,unit=0
-drive file=/tmp/OVMF_VARS.secboot.fd,if=pflash,format=raw,unit=1
-device ahci,id=ahci0 -vnc :0 -device bochs-display -m 8G -monitor stdio

The failure looks like Wayland starting and failing right away, this
repeats multiple times but after a number of restarts it may try to
pretend to work but then it crashes again. Things go back to normal when
the commit is reverted in the host kernel.

The CPU where this reproduces is fairly modern too (Intel(R) Xeon(R)
Silver 4410Y, Sapphire Rapids). I wish I could give additional details
to what exactly happens in the guest but I can't find anything useful in
the logs ("WARNING: Application 'org.gnome.Shell.desktop' killed by
signal 9") and I know too little (nothing?) about how modern Linux
graphics stack is organized :-( Cc: Gerd just in case.

-- 
Vitaly

