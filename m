Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35037DA94
	for <rcu@vger.kernel.org>; Fri, 30 Aug 2024 14:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725026789; cv=none; b=YGCpr0gRa8YCzvoEvYRzU73RxoK87iylMAW5aHYRKYwXEY4UBKOPTk07yYKuGgTeeV5SKRHAMCkypia0m9qEpIEXJm5xXeZCfv83bncy04B5VjGJckq0ftOCw2U1Y93iHMDH52uWX6j0H4+b7mqYOVMHkfyPgnNsqMjgUEGd/zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725026789; c=relaxed/simple;
	bh=DST8MfcDGblwIS1eTzURHIFjAr3HHDFnR86/z9ofTp8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jakrhYCd3/XxsyZFb4+GhEKhpMYoFeI0gpX9SVmzp3gNypcOzVw87jhNd5Qlq/y+BWivxPgaFLXtFzkmFmNZtGamD41iIwbbXfhsZ7CaMEL9kAZagWA9ixZt4nWn0PpX8vwT1c3gXjW1u7nbQAu7wIJxNL0jByq2A2MQAqZHe4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cg4XlUkn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cg4XlUkn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725026786;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zJ1umHWELLbD6rD5bt9p2nc0aqxMrB9ZCzjKVdabZQs=;
	b=cg4XlUknoRnmZjyV7TEALlaG4bpoVsg0WTH+nBFVLqmFf8qoKEZ1E30BZAjYBfb2huutXT
	HEuMKFwKm5iZcWV8SWA0TaV1brGBGrhYzt9GUG4S8YjV4uVr669DK/Bz8WNVW3cz95KXu1
	j7b5MApHxU/6wYAsN+uH2lA1Yg2SdOo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-94-Hd6S8nVvPRGty8QwmfvfPQ-1; Fri, 30 Aug 2024 10:06:25 -0400
X-MC-Unique: Hd6S8nVvPRGty8QwmfvfPQ-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-428076fef5dso17246785e9.2
        for <rcu@vger.kernel.org>; Fri, 30 Aug 2024 07:06:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725026784; x=1725631584;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zJ1umHWELLbD6rD5bt9p2nc0aqxMrB9ZCzjKVdabZQs=;
        b=sHQFn07+iByT6U8X+7oB2r1tdPFJq8sMwX7fPGaIPaajQr/tGc51Wi7YcCpssDcCQy
         hnsgt/lp8JavcYRFaXTs4eLR9cXHdrpdtdbMPRLzg+DsVrM8jIrbzLS/exdQGwC3aCWY
         KkXZceFsP0MusAfUlBv0hbZ6v12Yx4qvpi4TiwD1V6PP/7pQTFPcvvh3zTTC9Xoa4ltT
         J9YBYNOw95guNTVIzCekvgaTqbcJajXunyxQctlaw00pC5yorgXpeFDdw+wFnvQ1KbR3
         8Zc4SIGdri28hTd6EJRgdOosPrWi5MXWToQqZJnoP09Nw0Ezta6WNZ3SUKatigFrI1t5
         BeQw==
X-Forwarded-Encrypted: i=1; AJvYcCUo7yjnoJ/b4EAoHZsSYFxGuIEf7uOTura25GVToqRKZuaYSlRynqUqFBujXJCwdU+J1X4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHUl6goeUU+8OIhZsgbrrYz0yRSgojFJpTEkyRMci+E1kMrUAF
	jX7bKWgRQjX8/mWNl7Bt9ttOjBLRYUEhJjK0whDTA/bbv2wxaGuiIo1SawtN5Ry9p8xTID9NI2r
	6F++6je/yYvr7k3fHo5JGPdcr7xhl/zMcn5PsfSXBzZcjNJg7wQ==
X-Received: by 2002:a05:600c:354b:b0:427:d8fd:42a9 with SMTP id 5b1f17b1804b1-42bb025d668mr49865305e9.22.1725026783571;
        Fri, 30 Aug 2024 07:06:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGb7KISbfKwruBPGUn6q1h6/yXfRqmt0s850/4C3zu4HLhm5I+Hjs02kPeQGF3sg0PYgIXh3g==
X-Received: by 2002:a05:600c:354b:b0:427:d8fd:42a9 with SMTP id 5b1f17b1804b1-42bb025d668mr49864715e9.22.1725026782845;
        Fri, 30 Aug 2024 07:06:22 -0700 (PDT)
Received: from fedora (g2.ign.cz. [91.219.240.8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ba639671dsm81832555e9.5.2024.08.30.07.06.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 07:06:22 -0700 (PDT)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 kvm@vger.kernel.org, rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
 Kevin Tian <kevin.tian@intel.com>, Yan Zhao <yan.y.zhao@intel.com>, Yiwei
 Zhang <zzyiwei@google.com>, Lai Jiangshan <jiangshanlai@gmail.com>, "Paul
 E. McKenney" <paulmck@kernel.org>, Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH 5/5] KVM: VMX: Always honor guest PAT on CPUs that
 support self-snoop
In-Reply-To: <ZtHOr-kCqvCdUc_A@google.com>
References: <20240309010929.1403984-1-seanjc@google.com>
 <20240309010929.1403984-6-seanjc@google.com> <877cbyuzdn.fsf@redhat.com>
 <vuwlkftomgsnzsywjyxw6rcnycg3bve3o53svvxg3vd6xpok7o@k4ktmx5tqtmz>
 <871q26unq8.fsf@redhat.com> <ZtHOr-kCqvCdUc_A@google.com>
Date: Fri, 30 Aug 2024 16:06:21 +0200
Message-ID: <87seumt89u.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Sean Christopherson <seanjc@google.com> writes:

> On Fri, Aug 30, 2024, Vitaly Kuznetsov wrote:
>> Gerd Hoffmann <kraxel@redhat.com> writes:
>> 
>> >> Necroposting!
>> >> 
>> >> Turns out that this change broke "bochs-display" driver in QEMU even
>> >> when the guest is modern (don't ask me 'who the hell uses bochs for
>> >> modern guests', it was basically a configuration error :-). E.g:
>> >
>> > qemu stdvga (the default display device) is affected too.
>> >
>> 
>> So far, I was only able to verify that the issue has nothing to do with
>> OVMF and multi-vcpu, it reproduces very well with
>> 
>> $ qemu-kvm -machine q35,accel=kvm,kernel-irqchip=split -name guest=c10s
>> -cpu host -smp 1 -m 16384 -drive file=/var/lib/libvirt/images/c10s-bios.qcow2,if=none,id=drive-ide0-0-0
>> -device ide-hd,bus=ide.0,unit=0,drive=drive-ide0-0-0,id=ide0-0-0,bootindex=1
>> -vnc :0 -device VGA -monitor stdio --no-reboot
>> 
>> Comparing traces of working and broken cases, I couldn't find anything
>> suspicious but I may had missed something of course. For now, it seems
>> like a userspace misbehavior resulting in a segfault.
>
> Guest userspace?
>

Yes? :-) As Gerd described, video memory is "mapped into userspace so
the wayland / X11 display server can software-render into the buffer"
and it seems that wayland gets something unexpected in this memory and
crashes. 

-- 
Vitaly

