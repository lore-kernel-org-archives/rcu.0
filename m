Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C464CC433EF
	for <rcu@archiver.kernel.org>; Fri, 17 Dec 2021 17:02:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236360AbhLQRCg (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 17 Dec 2021 12:02:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:43338 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238029AbhLQRCf (ORCPT
        <rfc822;rcu@vger.kernel.org>); Fri, 17 Dec 2021 12:02:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639760554;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=58xC6/7sDobq7k3UfPIWPW94AtvXxt+V86z+2iDC+2w=;
        b=Urko740bB9htAI+7p+wyutL2cil/oVdU1hiaI/BR67km2WC42CuxDMCajpH4dK2Vs1t+kp
        IGEeiMGAwZoDWlqWi92wg3i54hhQBiRFNt+1XjytQfZacQcgwVyGJGLf8pDVFJGaOWmLbe
        XIVtrRMV+9txokyNCapc2uTrT8CJFHI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-507-yRh4V9TFP4eBme4WMhR6QA-1; Fri, 17 Dec 2021 12:02:33 -0500
X-MC-Unique: yRh4V9TFP4eBme4WMhR6QA-1
Received: by mail-wm1-f69.google.com with SMTP id b83-20020a1c1b56000000b0033283ea5facso2067094wmb.1
        for <rcu@vger.kernel.org>; Fri, 17 Dec 2021 09:02:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=58xC6/7sDobq7k3UfPIWPW94AtvXxt+V86z+2iDC+2w=;
        b=lR+8w6ColgPKdXJsF+cOuuoM9OramDxQPqP9Bl7KnUXtRSsxkFANp5Tq3eMbDHa9N8
         n7fSz8EeoUhCSx076txiwInZFZzu2OGRFOLx5Kp88FvqAyb7zVSaCPEUpnQJNHQ2xbTP
         ishXuWyxBQLVBH0LWNOi5IcSnYTlcFUFqagfZq9t6x/tEU/fSSIPPangBJYzBX/6M8dp
         +Qt3NGvCH+zqZl80nV5/n6lA3BC8QKe4Iflyz6kmd0qe2ALg/nQ9+YwX515exbqLlj+n
         GBk4cknwzUTz8s6l0yLcT4nw9f4mX6wlWFjSLTHHJ6MoF6MvE3PPtSX/jrO/Tsj5tYqS
         vAEQ==
X-Gm-Message-State: AOAM531DaZS30pzQjCMYv94zf1Gj+hi63vI5IAXYntLqEcuVbmd9D4Go
        Gz+ZxAHf5DoimjeBCBRRrMr9T6aCxF8xQzxjsK/AZ7yOIMO54zOql3LOgVQywQ/JrOq1LHJeEI3
        syRPaX2hMlTKu
X-Received: by 2002:a5d:50c2:: with SMTP id f2mr1630547wrt.459.1639760551530;
        Fri, 17 Dec 2021 09:02:31 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxt1I8ke5xrxCT2VayX74T7SOcgRXF4/LpFPypHzz/NgKLPu11J2MlPuURQrtM4+KYAlz3k6Q==
X-Received: by 2002:a5d:50c2:: with SMTP id f2mr1630536wrt.459.1639760551326;
        Fri, 17 Dec 2021 09:02:31 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312::ac3? ([2001:b07:6468:f312::ac3])
        by smtp.googlemail.com with ESMTPSA id u14sm8273562wrf.39.2021.12.17.09.02.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Dec 2021 09:02:30 -0800 (PST)
Message-ID: <4c369ca2-2ad0-4a02-90e9-2d82df6c289d@redhat.com>
Date:   Fri, 17 Dec 2021 18:02:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: Possible nohz-full/RCU issue in arm64 KVM
Content-Language: en-US
To:     paulmck@kernel.org
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        maz <maz@kernel.org>, frederic <frederic@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        rcu <rcu@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
References: <d80e440375896f75d45e227d40af60ca7ba24ceb.camel@redhat.com>
 <YbyO40zDW/kvUHEE@FVFF77S0Q05N>
 <70f112072d9496d21901946ea82832d3ed3a8cb2.camel@redhat.com>
 <Ybyg1r/Q6EfeuXGV@FVFF77S0Q05N>
 <9ab8107f-ff41-6a9e-57e1-a261bea93aca@redhat.com>
 <20211217160749.GS641268@paulmck-ThinkPad-P17-Gen-1>
 <f3d6095a-70aa-3da0-08a6-3caff2638809@redhat.com>
 <20211217164535.GU641268@paulmck-ThinkPad-P17-Gen-1>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20211217164535.GU641268@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On 12/17/21 17:45, Paul E. McKenney wrote:
> On Fri, Dec 17, 2021 at 05:34:04PM +0100, Paolo Bonzini wrote:
>> On 12/17/21 17:07, Paul E. McKenney wrote:
>>>> rcu_note_context_switch() is a point-in-time notification; it's not strictly
>>>> necessary, but it may improve performance a bit by avoiding unnecessary IPIs
>>>> from the RCU subsystem.
>>>>
>>>> There's no benefit from doing it when you're back from the guest, because at
>>>> that point the CPU is just running normal kernel code.
>>>
>>> Do scheduling-clock interrupts from guest mode have the "user" parameter
>>> set?  If so, that would keep RCU happy.
>>
>> No, thread is in supervisor mode.  But after every interrupt (timer tick or
>> anything), one of three things can happen:
>>
>> * KVM will go around the execution loop and invoke rcu_note_context_switch()
>> again
>>
>> * or KVM will go back to user space
> 
> Here "user space" is a user process as opposed to a guest OS?

Yes, that code runs from ioctl(KVM_RUN) and the ioctl will return to the 
calling process.

Paolo

>> * or the thread will be preempted
>>
>> and either will keep RCU happy as far as I understand.
> 
> Regardless of the answer to my question above, yes, these will keep
> RCU happy.  ;-)

