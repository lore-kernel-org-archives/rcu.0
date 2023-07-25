Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BBBBC04FDF
	for <rcu@archiver.kernel.org>; Tue, 25 Jul 2023 10:11:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231792AbjGYKL1 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 25 Jul 2023 06:11:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231552AbjGYKLZ (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 25 Jul 2023 06:11:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8427E10CB
        for <rcu@vger.kernel.org>; Tue, 25 Jul 2023 03:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690279837;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qHJHNAQ/EaLrVgiClukNB6YD2cCwQOLa9+8g/RD5pIg=;
        b=iY4wOsydtMEtxvUuDux6MVHCf2tojKmzGry+T6klLphKk6SXYPUWf5hBJrawogE13qw/PH
        2AjawmjJhIl2TYiDj9I+JHz9xDtotGkGBvQ2aEI3RZSEPDKHx/bmVODoS1rfHxEFpgH1Fy
        Hg5C7SoCJeT8AMYCsbUXtDy7h8TIMJk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-121-dkOICcl7MQukdiLbjjtCHQ-1; Tue, 25 Jul 2023 06:10:36 -0400
X-MC-Unique: dkOICcl7MQukdiLbjjtCHQ-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3fa8f8fb7b3so31723465e9.2
        for <rcu@vger.kernel.org>; Tue, 25 Jul 2023 03:10:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690279835; x=1690884635;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qHJHNAQ/EaLrVgiClukNB6YD2cCwQOLa9+8g/RD5pIg=;
        b=CBS8kGx74M8qXmU1iLd70C/SEMv/ibYHZX67hVcdMqOnKA9HLo3W7v7lifDfZERIm6
         ScWqyPvL6RWfxAGByjHe4V3ZOwE7Li6v31w5pR25v414gUdzbVRqoxOy8hby6L1zAEjT
         0oJtinPZSItf2NGmvBQvV4H6vw3SJh5xo2oTewoCqnjJViD3dZo3d+wMyF/rVx8FGGIf
         Wx2OS1ifxAx3TxmHVFbSMWwa1aulHDFr9dwbWsYw0vBhhRf8pkQlYpp0uhXTrpfAAvSu
         mPVo19cS08ZcPVttIKJm/2Eth0/ZqOOMLoywSAEdUuTpyHQWcjnKTuyQ7tbMCxnzq4MN
         QSFg==
X-Gm-Message-State: ABy/qLaqAFBSargeaR4iK9IzUoVhv7eXPqPJhEzuCwrrhOm25VGR22tP
        4wL+vvSUXWMesZI09OLSxBjIO9s/q0NsMkyGVP2N6JICC/Myf6QuxWyMkWeiAKmwGLiqes7GzAS
        N3QCClkzdKX3/
X-Received: by 2002:a7b:c3c8:0:b0:3fc:182:7eac with SMTP id t8-20020a7bc3c8000000b003fc01827eacmr9484356wmj.33.1690279835121;
        Tue, 25 Jul 2023 03:10:35 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEBwe5grVle2BJoQfU1CdlrA5E008mXbdTKHKW2tEfZga9rph2myp9KegOF9DFTCjiBwJ8J/Q==
X-Received: by 2002:a7b:c3c8:0:b0:3fc:182:7eac with SMTP id t8-20020a7bc3c8000000b003fc01827eacmr9484330wmj.33.1690279834786;
        Tue, 25 Jul 2023 03:10:34 -0700 (PDT)
Received: from vschneid.remote.csb ([149.12.7.81])
        by smtp.gmail.com with ESMTPSA id p1-20020a05600c204100b003fc17e8a1efsm15201059wmg.45.2023.07.25.03.10.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 03:10:34 -0700 (PDT)
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
In-Reply-To: <ZL7OoUMLZwfUttjV@lothringen>
References: <20230720163056.2564824-1-vschneid@redhat.com>
 <20230720163056.2564824-16-vschneid@redhat.com>
 <ZL6QI4mV-NKlh4Ox@localhost.localdomain>
 <xhsmh351dtfjj.mognet@vschneid.remote.csb> <ZL7OoUMLZwfUttjV@lothringen>
Date:   Tue, 25 Jul 2023 11:10:31 +0100
Message-ID: <xhsmhzg3ks3mw.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On 24/07/23 21:18, Frederic Weisbecker wrote:
> On Mon, Jul 24, 2023 at 05:55:44PM +0100, Valentin Schneider wrote:
>> I can make that a 'do {} while ()' instead to force at least one execution
>> of the cmpxchg().
>>
>> This is only about reducing the race window, right? If we're executing this
>> just as the target CPU is about to enter userspace, we're going to be in
>> racy territory anyway. Regardless, I'm happy to do that change.
>
> Right, it's only about narrowing down the race window. It probably don't matter
> in practice, but it's one less thing to consider for the brain :-)
>

Ack

> Also, why bothering with handling CONTEXT_IDLE?
>

I have reasons! I just swept them under the rug and didn't mention them :D
Also looking at the config dependencies again I got it wrong, but
nevertheless that means I get to ramble about it.

With NO_HZ_IDLE, we get CONTEXT_TRACKING_IDLE, so we get these
transitions:

  ct_idle_enter()
    ct_kernel_exit()
      ct_state_inc_clear_work()

  ct_idle_exit()
    ct_kernel_enter()
      ct_work_flush()

Now, if we just make CONTEXT_TRACKING_WORK depend on CONTEXT_TRACKING_IDLE
rather than CONTEXT_TRACKING_USER, we get to leverage the IPI deferral for
NO_HZ_IDLE kernels - in other words, we get to keep idle CPUs idle longer.

It's a completely different argument than reducing interference for
NOHZ_FULL userspace applications and I should have at the very least
mentioned it in the cover letter, but it's the exact same backing
mechanism.

Looking at it again, I'll probably make the CONTEXT_IDLE thing a separate
patch with a proper changelog.

