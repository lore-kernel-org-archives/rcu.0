Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1B05C433F5
	for <rcu@archiver.kernel.org>; Tue,  4 Jan 2022 17:10:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232022AbiADRKG (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 4 Jan 2022 12:10:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:33785 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231733AbiADRKG (ORCPT
        <rfc822;rcu@vger.kernel.org>); Tue, 4 Jan 2022 12:10:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641316205;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PLTIaY5gg/CGkjyFI0nVD1Ynp1qrSv98dwVoxTGL/gk=;
        b=AJW0duqdvpbTpNkkJJBxxZay8mHvtWn+4v0iQjIkvZi9YAb6hK0/S6XFzVUI7df99hSsn8
        8277Of9jev/146U9Q4n5RnY1SNlZYnbVV0T2B5GvD22qVhdBPw5kfaMEu8pJ2sZ0aZLoBJ
        d1+KF6U9RBMMiAU2HKyjQKbzaDmZwgA=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-673-2G1aP8SkPjWL4HS2Yy6xcA-1; Tue, 04 Jan 2022 12:10:04 -0500
X-MC-Unique: 2G1aP8SkPjWL4HS2Yy6xcA-1
Received: by mail-ed1-f71.google.com with SMTP id i5-20020a05640242c500b003f84839a8c3so25792539edc.6
        for <rcu@vger.kernel.org>; Tue, 04 Jan 2022 09:10:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=PLTIaY5gg/CGkjyFI0nVD1Ynp1qrSv98dwVoxTGL/gk=;
        b=cVHoCVNKFcILtAAHOfp5iiBxo+X2jRwZPzwKIS3KY0XnT3Dx+j521h2Ws+9ehGZqZk
         joHLrlzrI7yzHDPu26o4cI5wfAi64NUFhIb/JMWFAKGbSbiteGFXpHJPh6rrx/UWvwS/
         U3drqk/nazP/ZxKr/AKeG03dC5srTYNIczgH70Vj8RO3w+MBekmsQ3xJO3YuFRHw3X/F
         wSS4Ljju9mAUBifiGkUtW6PIp4nFJifEW8Nfe/Dj07ax1Vh3FOwDJDOIeaL9lkLM8V3A
         eAOlcVdJgYHJWVKS8CvoMGYElpUB4VeHLN9I5XOxMISTz2jJ4BFWgG8uq2Eplk1xh4N8
         AcGA==
X-Gm-Message-State: AOAM533G8y+4RTwwK0ovzF/EqanLKd1o6lOZa6Xy+64ZWeS9tcjeCxHB
        MBAEZ5hgHW+F2rFRtx9SvFrQ6Ucqd9HEH2QxzS0p5Q9/egg5/4c/6tByc+QMVuNfDxGiqkGhIUi
        jEf4quH28u1/+
X-Received: by 2002:a17:906:9f01:: with SMTP id fy1mr6911395ejc.475.1641316202910;
        Tue, 04 Jan 2022 09:10:02 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzg4c8oC/snOnarWsLYe2OuhHx3dyq7Vui9X2KCh4F+Gwu3wSidctLFczPe7rbJzItTjhvIEQ==
X-Received: by 2002:a17:906:9f01:: with SMTP id fy1mr6911372ejc.475.1641316202670;
        Tue, 04 Jan 2022 09:10:02 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e? ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
        by smtp.googlemail.com with ESMTPSA id w17sm14932963edu.48.2022.01.04.09.07.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jan 2022 09:10:02 -0800 (PST)
Message-ID: <b8e273bf-ae2c-cc5c-0d20-33f3dd12053c@redhat.com>
Date:   Tue, 4 Jan 2022 18:07:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: Possible nohz-full/RCU issue in arm64 KVM
Content-Language: en-US
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        paulmck <paulmck@kernel.org>, maz <maz@kernel.org>,
        frederic <frederic@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        rcu <rcu@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Anup Patel <Anup.Patel@wdc.com>
References: <d80e440375896f75d45e227d40af60ca7ba24ceb.camel@redhat.com>
 <YbyO40zDW/kvUHEE@FVFF77S0Q05N>
 <70f112072d9496d21901946ea82832d3ed3a8cb2.camel@redhat.com>
 <Ybyg1r/Q6EfeuXGV@FVFF77S0Q05N>
 <9ab8107f-ff41-6a9e-57e1-a261bea93aca@redhat.com>
 <YdR4N9QVYOzjowAb@FVFF77S0Q05N>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <YdR4N9QVYOzjowAb@FVFF77S0Q05N>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On 1/4/22 17:39, Mark Rutland wrote:
> My main issue here was just that it's really difficult to see how the
> entry/exit logic is balanced, and I reckon we can solve that by splitting
> guest_{enter,exit}_irqoff() into helper functions to handle the vtime
> accounting separately from the context tracking, so that arch code can do
> something like:
> 
>    guest_timing_enter_irqoff();
>    
>    guest_eqs_enter_irqoff();
>    < actually run vCPU here >
>    guest_eqs_exit_irqoff();
>    
>    < handle pending IRQs here >
>    
>    guest_timing_exit_irqoff();
> 
> ... which I hope should work for RISC-V too.
> 
> I've had a go, and I've pushed out a WIP to:
> 
>    https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/log/?h=arm64/kvm/rcu

Yes, you have a point and it makes sense for x86 too.  You can send me a 
topic branch once you get all the acks.  Thanks!

Paolo

