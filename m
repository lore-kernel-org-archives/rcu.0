Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57E59C433F5
	for <rcu@archiver.kernel.org>; Tue, 11 Jan 2022 11:32:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349508AbiAKLcp (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 11 Jan 2022 06:32:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:37452 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349505AbiAKLcm (ORCPT
        <rfc822;rcu@vger.kernel.org>); Tue, 11 Jan 2022 06:32:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641900762;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ntz4OdwBNqZu8v1ik+qX1K0Vqvd5kyFiJX82I/JSWBM=;
        b=ExeJO+MH2HDcaP5egKhOAmQMP4Qe45hQmP0MpMkZ56xPoBCxmBAjHSBvW1eKUn5+xZ5Pjy
        h/UaaFHYoqttZCk82zKrSGbIdpsjmgQLS0lYdkXIwQNe+qGBexKPqM/jRK4u2IT7Idgz1K
        xDE9JdfhZQ9MH0Us63ZXdgzixCT4y+A=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-317-92TVHzWbMu6HsgO6cdSSFg-1; Tue, 11 Jan 2022 06:32:40 -0500
X-MC-Unique: 92TVHzWbMu6HsgO6cdSSFg-1
Received: by mail-wm1-f70.google.com with SMTP id n14-20020a7bcbce000000b003488820f0d9so1645820wmi.8
        for <rcu@vger.kernel.org>; Tue, 11 Jan 2022 03:32:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=Ntz4OdwBNqZu8v1ik+qX1K0Vqvd5kyFiJX82I/JSWBM=;
        b=DDMXvSPH7lMARqbX8ZlkWHH5lSPZh3hye6VXOcDYwB+LKrjkfgZq0++hAtNH/vTMpf
         V9RuYWI2PPYHRiqab6fb07NEf+DXQ82sW77qvFuyfOG6bkzQIMJK1JuQiRb5Zx6uMpcd
         YBPgigh8MOrRRLz8pHUuElUAl6QHVzUcrUsbNK5oW5m/pWKW1I8zTTkOzw84ZNo6206y
         Trwn6N55GWJ+lAaFRlAxPmxDULPnwgbaeA1iLAdGkkkheKGmJdKskGRApLRRPabPKQAG
         O/A65qe2Fb6j2yHXBt5Dvs96gtrCuSyhAwY0hL8TSQoqpAIg3X/S7wzCeI+mKL23qSMe
         MFZg==
X-Gm-Message-State: AOAM531EZ3qOCceRjRVuiXideFmOtoCDfTQjVpSl74ME3lDWaa5Whi1c
        oPcpZnCIjC9+1h22BMEK1QmfMsOelcim6oDG5OI9W+NQY6SY+4XVITV99G5urTqQ4dYDCcpo17w
        E8TtgKBVHvsTf
X-Received: by 2002:a05:600c:1f16:: with SMTP id bd22mr638649wmb.55.1641900759548;
        Tue, 11 Jan 2022 03:32:39 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxVL3iNrW3WKpYn6GzQuj8SMBM75HxOEOHTlJ+vpSpokIuvZWIzUcmFzLx+N+TQE1uqDKbg/Q==
X-Received: by 2002:a05:600c:1f16:: with SMTP id bd22mr638624wmb.55.1641900759341;
        Tue, 11 Jan 2022 03:32:39 -0800 (PST)
Received: from ?IPv6:2a0c:5a80:1e09:d600:637e:7f1b:a4a0:fc92? ([2a0c:5a80:1e09:d600:637e:7f1b:a4a0:fc92])
        by smtp.gmail.com with ESMTPSA id u3sm11320283wrs.0.2022.01.11.03.32.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 03:32:39 -0800 (PST)
Message-ID: <399d8805ca09f7d3c905b8c653abf60dd7141574.camel@redhat.com>
Subject: Re: Possible nohz-full/RCU issue in arm64 KVM
From:   Nicolas Saenz Julienne <nsaenzju@redhat.com>
To:     Mark Rutland <mark.rutland@arm.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     paulmck <paulmck@kernel.org>, maz <maz@kernel.org>,
        frederic <frederic@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        rcu <rcu@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Anup Patel <Anup.Patel@wdc.com>
Date:   Tue, 11 Jan 2022 12:32:38 +0100
In-Reply-To: <YdR4N9QVYOzjowAb@FVFF77S0Q05N>
References: <d80e440375896f75d45e227d40af60ca7ba24ceb.camel@redhat.com>
         <YbyO40zDW/kvUHEE@FVFF77S0Q05N>
         <70f112072d9496d21901946ea82832d3ed3a8cb2.camel@redhat.com>
         <Ybyg1r/Q6EfeuXGV@FVFF77S0Q05N>
         <9ab8107f-ff41-6a9e-57e1-a261bea93aca@redhat.com>
         <YdR4N9QVYOzjowAb@FVFF77S0Q05N>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.2 (3.42.2-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hi Mark,

On Tue, 2022-01-04 at 16:39 +0000, Mark Rutland wrote:
> On Fri, Dec 17, 2021 at 04:54:22PM +0100, Paolo Bonzini wrote:
> > On 12/17/21 15:38, Mark Rutland wrote:
> > > For example kvm_guest_enter_irqoff() calls guest_enter_irq_off() which calls
> > > vtime_account_guest_enter(), but kvm_guest_exit_irqoff() doesn't call
> > > guest_exit_irq_off() and the call to vtime_account_guest_exit() is open-coded
> > > elsewhere. Also, guest_enter_irq_off() conditionally calls
> > > rcu_virt_note_context_switch(), but I can't immediately spot anything on the
> > > exit side that corresponded with that, which looks suspicious.
> > 
> > rcu_note_context_switch() is a point-in-time notification; it's not strictly
> > necessary, but it may improve performance a bit by avoiding unnecessary IPIs
> > from the RCU subsystem.
> > 
> > There's no benefit from doing it when you're back from the guest, because at
> > that point the CPU is just running normal kernel code.
> 
> I see.
> 
> My main issue here was just that it's really difficult to see how the
> entry/exit logic is balanced, and I reckon we can solve that by splitting
> guest_{enter,exit}_irqoff() into helper functions to handle the vtime
> accounting separately from the context tracking, so that arch code can do
> something like:
> 
>   guest_timing_enter_irqoff();
>   
>   guest_eqs_enter_irqoff();
>   < actually run vCPU here >
>   guest_eqs_exit_irqoff();
>   
>   < handle pending IRQs here >
>   
>   guest_timing_exit_irqoff();
> 
> ... which I hope should work for RISC-V too.
> 
> I've had a go, and I've pushed out a WIP to:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/log/?h=arm64/kvm/rcu

Had a look at the patches and they seeem OK to me.

Thanks!

-- 
Nicolás Sáenz

