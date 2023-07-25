Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8444DC001DF
	for <rcu@archiver.kernel.org>; Tue, 25 Jul 2023 13:06:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233424AbjGYNGh (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 25 Jul 2023 09:06:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbjGYNGg (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 25 Jul 2023 09:06:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 092B3E78
        for <rcu@vger.kernel.org>; Tue, 25 Jul 2023 06:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690290354;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Sjst0ANUHPkhmyS9EMxljg+0hKTtA2LkvoCccenEaWc=;
        b=F7+xFVN/UTPtioUDXmny4WuOauzeqiMr3GZY7z4ZN3NSNic3rnB+YM9YlvrM4oJIRcpCBR
        EUZkTCN/IFwszgRPwQqPwmuiuHakAykTSIQ66vIQqAu2TWbA+DLVAG6WUkHPt+sDmTvotf
        yFAjlzdpsTNHhc69ehl4uvxwy8/lHq0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-hOBlPMTeMI2YxmlzwmNZug-1; Tue, 25 Jul 2023 09:05:52 -0400
X-MC-Unique: hOBlPMTeMI2YxmlzwmNZug-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-317421b94a4so1371382f8f.3
        for <rcu@vger.kernel.org>; Tue, 25 Jul 2023 06:05:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690290352; x=1690895152;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Sjst0ANUHPkhmyS9EMxljg+0hKTtA2LkvoCccenEaWc=;
        b=WDy78X8kiLsZ8LmHID4AmI6eJJMxQ9Caw4b7uvDixQdMrkoH0fW+aTrY9F+iYfpn5y
         JCTrL10weKOJebP90ByANVejdWf0pSVWLZ96jNSN6KE9kLd30mjPDA4Ui8+lRDaRXT1m
         5aZdO5mXiDQ2PFq6X6YxTpvLCrM+lAVXymuP+VqncUi5HUTOGedYhjVlMxWLjDv/JuYr
         6iiZMj8WcMgkFSh/qQtpxY/PleUVnP2xXSRzGCdDvRq94ZT47cY4GtkX5EX5Ij9S0YBd
         a9PVparqgyXdj3c8hSZikeU358IU5Shr1cjouaskTwrqVKZKYrpSeWcihjLjLYdhHDac
         onQw==
X-Gm-Message-State: ABy/qLbx/gagb2l19zMRxBHofFSvT19y1o9fPvEJhPg2pbxkwv0dYi3E
        uRrn9RmE6Zcgap4qjfftC9JZfG3dFiymjF3F+pNlms1JFszGuNKeDy77cqDbzVCJ7sMu3Tq1/Uy
        k998OTSDIVLhD
X-Received: by 2002:a05:6000:4c3:b0:314:3f98:a788 with SMTP id h3-20020a05600004c300b003143f98a788mr9662080wri.7.1690290351825;
        Tue, 25 Jul 2023 06:05:51 -0700 (PDT)
X-Google-Smtp-Source: APBJJlF3IfiPQXJmTRIbnVDIkRhO1QGeOmJQGB2V7Ax+LFUYp7XQ/uOSm8c19TiPQx/PfreNkIV1Uw==
X-Received: by 2002:a05:6000:4c3:b0:314:3f98:a788 with SMTP id h3-20020a05600004c300b003143f98a788mr9662062wri.7.1690290351507;
        Tue, 25 Jul 2023 06:05:51 -0700 (PDT)
Received: from vschneid.remote.csb ([149.12.7.81])
        by smtp.gmail.com with ESMTPSA id a15-20020adfeecf000000b00311d8c2561bsm16238717wrp.60.2023.07.25.06.05.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 06:05:51 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org,
        bpf@vger.kernel.org, x86@kernel.org, rcu@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Zqiang <qiang.zhang1211@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Jason Baron <jbaron@akamai.com>,
        Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Juerg Haefliger <juerg.haefliger@canonical.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Nadav Amit <namit@vmware.com>,
        Dan Carpenter <error27@gmail.com>,
        Chuang Wang <nashuiliang@gmail.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Petr Mladek <pmladek@suse.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>, Song Liu <song@kernel.org>,
        Julian Pidancet <julian.pidancet@oracle.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Dionna Glaze <dionnaglaze@google.com>,
        Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Yair Podemsky <ypodemsk@redhat.com>
Subject: Re: [RFC PATCH v2 15/20] context-tracking: Introduce work deferral
 infrastructure
In-Reply-To: <ZL+wgn76H1em9hZU@lothringen>
References: <20230720163056.2564824-1-vschneid@redhat.com>
 <20230720163056.2564824-16-vschneid@redhat.com>
 <ZL6QI4mV-NKlh4Ox@localhost.localdomain>
 <xhsmh351dtfjj.mognet@vschneid.remote.csb> <ZL7OoUMLZwfUttjV@lothringen>
 <xhsmhzg3ks3mw.mognet@vschneid.remote.csb> <ZL+wgn76H1em9hZU@lothringen>
Date:   Tue, 25 Jul 2023 14:05:47 +0100
Message-ID: <xhsmhwmyorvis.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On 25/07/23 13:22, Frederic Weisbecker wrote:
> On Tue, Jul 25, 2023 at 11:10:31AM +0100, Valentin Schneider wrote:
>> I have reasons! I just swept them under the rug and didn't mention them :D
>> Also looking at the config dependencies again I got it wrong, but
>> nevertheless that means I get to ramble about it.
>>
>> With NO_HZ_IDLE, we get CONTEXT_TRACKING_IDLE, so we get these
>> transitions:
>>
>>   ct_idle_enter()
>>     ct_kernel_exit()
>>       ct_state_inc_clear_work()
>>
>>   ct_idle_exit()
>>     ct_kernel_enter()
>>       ct_work_flush()
>>
>> Now, if we just make CONTEXT_TRACKING_WORK depend on CONTEXT_TRACKING_IDLE
>> rather than CONTEXT_TRACKING_USER, we get to leverage the IPI deferral for
>> NO_HZ_IDLE kernels - in other words, we get to keep idle CPUs idle longer.
>>
>> It's a completely different argument than reducing interference for
>> NOHZ_FULL userspace applications and I should have at the very least
>> mentioned it in the cover letter, but it's the exact same backing
>> mechanism.
>>
>> Looking at it again, I'll probably make the CONTEXT_IDLE thing a separate
>> patch with a proper changelog.
>
> Ok should that be a seperate Kconfig? This indeed can bring power improvement
> but at the cost of more overhead from the sender. A balance to be measured...

Yep agreed, I'll make that an optional config.

