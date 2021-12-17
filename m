Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB296C433EF
	for <rcu@archiver.kernel.org>; Fri, 17 Dec 2021 11:52:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235559AbhLQLwE (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 17 Dec 2021 06:52:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:30202 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230396AbhLQLwD (ORCPT
        <rfc822;rcu@vger.kernel.org>); Fri, 17 Dec 2021 06:52:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639741922;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=VbaoBagpyxB2kBwkaE/GX54RBymyP3RskJ4qz0SPZ7M=;
        b=g7lJAb3Jcqg91RdT9/aOpyolNXhn2ToVxPDZArEzwDXhSj0GoE6MOegSBV5lUp2P4VMbbB
        PcYe1JMIu6h2PbYUUeKo35T+sGPet/18BosuvNSr/0UNfVVQRZVeCluS8mVNIhu92iFZK4
        yzv1/FHcuQEw5kPn0ppPJ247xIJ2CBw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-413-Tu-8Qt0OM_qA7f5JEzlMzg-1; Fri, 17 Dec 2021 06:51:59 -0500
X-MC-Unique: Tu-8Qt0OM_qA7f5JEzlMzg-1
Received: by mail-wr1-f71.google.com with SMTP id p1-20020adfba81000000b001a25b07ff53so218582wrg.22
        for <rcu@vger.kernel.org>; Fri, 17 Dec 2021 03:51:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:user-agent
         :mime-version:content-transfer-encoding;
        bh=VbaoBagpyxB2kBwkaE/GX54RBymyP3RskJ4qz0SPZ7M=;
        b=MK/zXNxKH12TACEFryDTlcN4Q7o1eGf3Sz0BBGOJkNz+Q5hX0VZ5DYEH2g7siv+2Vl
         JpuDK4yl46ZUck34EMVxJveez+sxeOM/7aQrkIPsJFWqwykXWkwPwGRqcKJGL5J5n5cK
         JOOhYE6bktsA//cZ4KwVr8F8PTlFPlPvSJ/nN2ynRomwdoV+tMYMex2j8z63VFV8wXUG
         Kiiy66sg9mpM9clhy8IBexcvCBUrDivjj2bvgKmZo2wq7uYBpCxNAY7z0hx07iFS7cVJ
         dLgDsTBK7xrAIjsFSPUZS/pSbetRREICMYMnqe4NsjFwehCyeZuq50+w5B5c1+4nQVkW
         hytQ==
X-Gm-Message-State: AOAM531PCC6t2BF/4gLPgSxmirVxD+qTQM9EOxxyLDTsg/v5uiiNHRaG
        cNxj3+OKtqcVrinr967jOgeiCenmw93sj9Zl7y8vaxfI9sjU7Vp/BbJ7iPqpMqGN4Z/sqKz3i+y
        KUkmrevEIMpKv
X-Received: by 2002:a5d:60d1:: with SMTP id x17mr2256899wrt.208.1639741918359;
        Fri, 17 Dec 2021 03:51:58 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzuWJ1oAUOR9ZdBi/KYt7RPzUDX8mfw0bBNc+p+s/E8DzmY72v3omfLECQ4vU+R5FsDQMAaaQ==
X-Received: by 2002:a5d:60d1:: with SMTP id x17mr2256884wrt.208.1639741918131;
        Fri, 17 Dec 2021 03:51:58 -0800 (PST)
Received: from ?IPv6:2a0c:5a80:3b0e:bd00:1099:cf34:d27f:de8a? ([2a0c:5a80:3b0e:bd00:1099:cf34:d27f:de8a])
        by smtp.gmail.com with ESMTPSA id f3sm7117441wrm.96.2021.12.17.03.51.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Dec 2021 03:51:57 -0800 (PST)
Message-ID: <d80e440375896f75d45e227d40af60ca7ba24ceb.camel@redhat.com>
Subject: Possible nohz-full/RCU issue in arm64 KVM
From:   Nicolas Saenz Julienne <nsaenzju@redhat.com>
To:     Mark Rutland <mark.rutland@arm.com>, maz <maz@kernel.org>
Cc:     Will Deacon <will@kernel.org>, paulmck <paulmck@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        rcu <rcu@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        frederic <frederic@kernel.org>, kvmarm@lists.cs.columbia.edu,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Fri, 17 Dec 2021 12:51:57 +0100
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.2 (3.42.2-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hi All,
arm64's guest entry code does the following:

int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
{
	[...]

	guest_enter_irqoff();

	ret = kvm_call_hyp_ret(__kvm_vcpu_run, vcpu);

	[...]

	local_irq_enable();

	/*
	 * We do local_irq_enable() before calling guest_exit() so
	 * that if a timer interrupt hits while running the guest we
	 * account that tick as being spent in the guest.  We enable
	 * preemption after calling guest_exit() so that if we get
	 * preempted we make sure ticks after that is not counted as
	 * guest time.
	 */
	guest_exit();
	[...]
}


On a nohz-full CPU, guest_{enter,exit}() delimit an RCU extended quiescent
state (EQS). Any interrupt happening between local_irq_enable() and
guest_exit() should disable that EQS. Now, AFAICT all el0 interrupt handlers do
the right thing if trggered in this context, but el1's won't. Is it possible to
hit an el1 handler (for example __el1_irq()) there?

Thanks,

-- 
Nicolás Sáenz

