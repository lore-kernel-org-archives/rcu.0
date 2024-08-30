Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448301B1D65
	for <rcu@vger.kernel.org>; Fri, 30 Aug 2024 14:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725028636; cv=none; b=VwvwWWM3LleN3iWITs6lOLOTwjSY2ofHZXfvxMzGKXNfpv5UDta9ZSNJRvnTjIZ6tF7VdPp/DtFZnN8484Xp3/GNlJ89RuVZri8VusVo0uG8rLEPsaFcKTTCsa0CZWJQnPNJEtVSBWp2YOZ3oBuXrm5L+2skQtxB+WnsufJYg68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725028636; c=relaxed/simple;
	bh=V3LYwBVfusskf5TId8gLHE1yuDhwHuX77AKmxh+YuxY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OETSDJqZ5KfznyrEffNnTgwrNLwlxWaKknqu3f97fKOCtTGJWAkP2IKbyZWvhPaqCC6rM0l8cs1+I52HUZog8csD/GBwVi/AOahGVBonV1wMle/6uzb1ZIFVPKQJE2Gkx14Xr/tzhKz/EIxMRz3/k51u9rxfYDeT/mSHI3FTxww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UePCUnYy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UePCUnYy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725028634;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oXMp7uWH/N7bIuo3ya5a5ES0R5pph2PC7v2bOFZblKs=;
	b=UePCUnYyXk+PFcNmjuZjGe7zVNvMLNmcSJeQRjtgPCjazAWSSbjS4pMuP7Ta0SIU36tm4D
	MCfNgBWS94mbHNzde6uSIidMAhJcXmwWDb1MCB6UO4XfnnIFx9FuRJ315Mm5kMxxgLiIjW
	QGHVf/44rWLrW24XkBd8N0ja05O0tmY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-0mQiliK4MP-ntWQ3yQsvHg-1; Fri, 30 Aug 2024 10:37:13 -0400
X-MC-Unique: 0mQiliK4MP-ntWQ3yQsvHg-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-371a2dcd8c2so1086240f8f.2
        for <rcu@vger.kernel.org>; Fri, 30 Aug 2024 07:37:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725028632; x=1725633432;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oXMp7uWH/N7bIuo3ya5a5ES0R5pph2PC7v2bOFZblKs=;
        b=oRioqmrcYAd7YBqRNSguxQ60AlL1u9n3ZR38BL5Mg/vDJ4dg3/33dy/9hl6dQcBXN7
         kqq/bM0WwVNsi8QVXzXApXZNRduuBk00q89OGhzGtaWYpgRiLBeHjO6Ug46SQItcIa1X
         /dTk1mr9nqVt7RP9Y3bac4qpe5UPd5ROPBx6o4M0S/3/fPY9XQa1FU4A7a64dtmsbxS6
         dVZgBfjeoRhfCU9SieHOvpIGfZhIdT0vFdSQfBh05MhgXkgaaB0OuxIYlkTLbBmuqTVE
         nA3e+KlsAsCsMC1YEpmWMEBJ2ml/0MBmxgsY+q5rNXvtxRmdVwIgyxO9m3pkWQKdYAae
         oFhA==
X-Forwarded-Encrypted: i=1; AJvYcCUgfkeP1hmM6BcCxwrbKM0Wblfh6WQsC5ZQgQtIQ9PSCqPv+REpFvqPQCkX98ximKqJvLk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQn56GEYvsqPrdXKZoqcrixMU7xzd/ue2Sflk9khpDiQdnKuSW
	WZ0OKWZ/ZVPWB1aiHifXn7nVlKZoQ5c5bxvjGAbrPc3V1mjlPy0Bc+LDYp4oawdR5GcL+vHir0q
	R2w2l5VwnpfEP+Mu5IaBVH5OEB877h6KQRa2ESNaQc+cFju4EPQ==
X-Received: by 2002:adf:e105:0:b0:371:8a3a:680a with SMTP id ffacd0b85a97d-3749b56145amr4121120f8f.32.1725028631777;
        Fri, 30 Aug 2024 07:37:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHFYgXNQ2yY6fOL1KrOlEnGq7ndk/i4ruj17NaJHBuCgglUICGU9LPO8teX4/pN12Jf+eJJPg==
X-Received: by 2002:adf:e105:0:b0:371:8a3a:680a with SMTP id ffacd0b85a97d-3749b56145amr4121106f8f.32.1725028631239;
        Fri, 30 Aug 2024 07:37:11 -0700 (PDT)
Received: from fedora (g2.ign.cz. [91.219.240.8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3749ef81146sm4175385f8f.82.2024.08.30.07.37.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 07:37:10 -0700 (PDT)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 kvm@vger.kernel.org, rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
 Kevin Tian <kevin.tian@intel.com>, Yan Zhao <yan.y.zhao@intel.com>, Yiwei
 Zhang <zzyiwei@google.com>, Lai Jiangshan <jiangshanlai@gmail.com>, "Paul
 E. McKenney" <paulmck@kernel.org>, Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH 5/5] KVM: VMX: Always honor guest PAT on CPUs that
 support self-snoop
In-Reply-To: <87seumt89u.fsf@redhat.com>
References: <20240309010929.1403984-1-seanjc@google.com>
 <20240309010929.1403984-6-seanjc@google.com> <877cbyuzdn.fsf@redhat.com>
 <vuwlkftomgsnzsywjyxw6rcnycg3bve3o53svvxg3vd6xpok7o@k4ktmx5tqtmz>
 <871q26unq8.fsf@redhat.com> <ZtHOr-kCqvCdUc_A@google.com>
 <87seumt89u.fsf@redhat.com>
Date: Fri, 30 Aug 2024 16:37:10 +0200
Message-ID: <87plpqt6uh.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Vitaly Kuznetsov <vkuznets@redhat.com> writes:

> Sean Christopherson <seanjc@google.com> writes:
>
>> On Fri, Aug 30, 2024, Vitaly Kuznetsov wrote:
>>> Gerd Hoffmann <kraxel@redhat.com> writes:
>>> 
>>> >> Necroposting!
>>> >> 
>>> >> Turns out that this change broke "bochs-display" driver in QEMU even
>>> >> when the guest is modern (don't ask me 'who the hell uses bochs for
>>> >> modern guests', it was basically a configuration error :-). E.g:
>>> >
>>> > qemu stdvga (the default display device) is affected too.
>>> >
>>> 
>>> So far, I was only able to verify that the issue has nothing to do with
>>> OVMF and multi-vcpu, it reproduces very well with
>>> 
>>> $ qemu-kvm -machine q35,accel=kvm,kernel-irqchip=split -name guest=c10s
>>> -cpu host -smp 1 -m 16384 -drive file=/var/lib/libvirt/images/c10s-bios.qcow2,if=none,id=drive-ide0-0-0
>>> -device ide-hd,bus=ide.0,unit=0,drive=drive-ide0-0-0,id=ide0-0-0,bootindex=1
>>> -vnc :0 -device VGA -monitor stdio --no-reboot
>>> 
>>> Comparing traces of working and broken cases, I couldn't find anything
>>> suspicious but I may had missed something of course. For now, it seems
>>> like a userspace misbehavior resulting in a segfault.
>>
>> Guest userspace?
>>
>
> Yes? :-) As Gerd described, video memory is "mapped into userspace so
> the wayland / X11 display server can software-render into the buffer"
> and it seems that wayland gets something unexpected in this memory and
> crashes. 

Also, I don't know if it helps or not, but out of two hunks in
377b2f359d1f, it is the vmx_get_mt_mask() one which brings the
issue. I.e. the following is enough to fix things:

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index f18c2d8c7476..733a0c45d1a6 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -7659,13 +7659,11 @@ u8 vmx_get_mt_mask(struct kvm_vcpu *vcpu, gfn_t gfn, bool is_mmio)
 
        /*
         * Force WB and ignore guest PAT if the VM does NOT have a non-coherent
-        * device attached and the CPU doesn't support self-snoop.  Letting the
-        * guest control memory types on Intel CPUs without self-snoop may
-        * result in unexpected behavior, and so KVM's (historical) ABI is to
-        * trust the guest to behave only as a last resort.
+        * device attached.  Letting the guest control memory types on Intel
+        * CPUs may result in unexpected behavior, and so KVM's ABI is to trust
+        * the guest to behave only as a last resort.
         */
-       if (!static_cpu_has(X86_FEATURE_SELFSNOOP) &&
-           !kvm_arch_has_noncoherent_dma(vcpu->kvm))
+       if (!kvm_arch_has_noncoherent_dma(vcpu->kvm))
                return (MTRR_TYPE_WRBACK << VMX_EPT_MT_EPTE_SHIFT) | VMX_EPT_IPAT_BIT;
 
        return (MTRR_TYPE_WRBACK << VMX_EPT_MT_EPTE_SHIFT);


-- 
Vitaly

