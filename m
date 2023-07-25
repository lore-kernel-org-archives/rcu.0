Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DCB2C0015E
	for <rcu@archiver.kernel.org>; Tue, 25 Jul 2023 14:04:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232159AbjGYOEK (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 25 Jul 2023 10:04:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232147AbjGYOEJ (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 25 Jul 2023 10:04:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E66881FC9
        for <rcu@vger.kernel.org>; Tue, 25 Jul 2023 07:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690293804;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uGwtpv4sQ6tMlJnBprHpZy+A2shb5owm6FTDMaQEmXQ=;
        b=QBE94+KygCiaAoBdmIFkuhqEiEpfz5v8JIy4/Ac6AlHtOed1d80dobXqcVEAC/ZUOFQJ+T
        mjgwkjcru8GfRTAnM64vWyhgvYSf5c79hrr8scu2ulDeSJLOhhNQ+ETiRDykhLbG0Cic4P
        +6vhdY2kDHYrPmoGLefELu2blJIPUS4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-199-Rjvn4AVmP5GAXzu6bAFqNA-1; Tue, 25 Jul 2023 10:03:21 -0400
X-MC-Unique: Rjvn4AVmP5GAXzu6bAFqNA-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3fb416d7731so27517145e9.2
        for <rcu@vger.kernel.org>; Tue, 25 Jul 2023 07:03:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690293799; x=1690898599;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uGwtpv4sQ6tMlJnBprHpZy+A2shb5owm6FTDMaQEmXQ=;
        b=E57PljnsjZHH95zZAX+vH+diuFx2vPEr//HnjeLyZORkqelwjAwXXkf6cof8x+MiMz
         Ckv0T44rHKa3AdTAkKA98Guhp6Ni9IrNK2P5QFrV1PPtJwXtNrQpFK+DmMrr4R6NmGtH
         iSVctNxhDbHHAmUfmRY8EQvBPW7ckusW4uyu7YBacOicmz9yId8DNtPESWfDkAr0OX4y
         DDAs1cRW9ISQoP+A3bQeuZrf47+iL4zBsO81CzSsuHJ4WBWpwUHw0qJSggDrUaAjb2wt
         NXYZNfnROyIZTeXXTlhCj0cqovfymogDiQb7gKwVarteSiFg6QMv40CpzQ+5EyrHLdB0
         UTXA==
X-Gm-Message-State: ABy/qLZEIL870qS+OOFba/D89Sdnp2F3uZez6CfQeiczzxu9h2CI0umi
        hem+G8D8yr1tyKnOu/9zkA2/z67uxB1aPoaGLMsiPnObHHoBP6HK6Qhc35EeiS716GXCcT7Q0Zo
        62HaPxQc5CgPM
X-Received: by 2002:a05:600c:2981:b0:3fb:b890:128b with SMTP id r1-20020a05600c298100b003fbb890128bmr9613804wmd.27.1690293798848;
        Tue, 25 Jul 2023 07:03:18 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGWt7E0uSkTs/ryo2PFkVv/T+3yWUu9tffF3NSN1ZjOzS6i3uoLFxbI/VM6mSJfkjz65gbRPQ==
X-Received: by 2002:a05:600c:2981:b0:3fb:b890:128b with SMTP id r1-20020a05600c298100b003fbb890128bmr9613787wmd.27.1690293798543;
        Tue, 25 Jul 2023 07:03:18 -0700 (PDT)
Received: from vschneid.remote.csb ([149.12.7.81])
        by smtp.gmail.com with ESMTPSA id s15-20020a05600c044f00b003fbc89af035sm13424142wmb.17.2023.07.25.07.03.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 07:03:18 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@intel.com>
Cc:     Nadav Amit <namit@vmware.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-trace-kernel@vger.kernel.org" 
        <linux-trace-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, bpf <bpf@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
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
        Frederic Weisbecker <frederic@kernel.org>,
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
Subject: Re: [RFC PATCH v2 20/20] x86/mm, mm/vmalloc: Defer
 flush_tlb_kernel_range() targeting NOHZ_FULL CPUs
In-Reply-To: <20230725132155.GJ3765278@hirez.programming.kicks-ass.net>
References: <20230720163056.2564824-1-vschneid@redhat.com>
 <20230720163056.2564824-21-vschneid@redhat.com>
 <188AEA79-10E6-4DFF-86F4-FE624FD1880F@vmware.com>
 <xhsmh8rb5tui1.mognet@vschneid.remote.csb>
 <2284d0db-f94a-e059-7bd0-bab4f112ed35@intel.com>
 <20230725132155.GJ3765278@hirez.programming.kicks-ass.net>
Date:   Tue, 25 Jul 2023 15:03:15 +0100
Message-ID: <xhsmhr0owrsv0.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org


Sorry, I missed out Dave's email, so now I'm taking my time to page (hah!)
all of this.

On 25/07/23 15:21, Peter Zijlstra wrote:
> On Mon, Jul 24, 2023 at 10:40:04AM -0700, Dave Hansen wrote:
>
>> TLB flushes for freed page tables are another game entirely.  The CPU is
>> free to cache any part of the paging hierarchy it wants at any time.
>> It's also free to set accessed and dirty bits at any time, even for
>> instructions that may never execute architecturally.
>>
>> That basically means that if you have *ANY* freed page table page
>> *ANYWHERE* in the page table hierarchy of any CPU at any time ... you're
>> screwed.
>>
>> There's no reasoning about accesses or ordering.  As soon as the CPU
>> does *anything*, it's out to get you.
>>

OK, I feel like I need to go back do some more reading now, but I think I
get the difference. Thanks for spelling it out.

>> You're going to need to do something a lot more radical to deal with
>> free page table pages.
>
> Ha! IIRC the only thing we can reasonably do there is to have strict
> per-cpu page-tables such that NOHZ_FULL CPUs can be isolated. That is,
> as long we the per-cpu tables do not contain -- and have never contained
> -- a particular table page, we can avoid flushing it. Because if it
> never was there, it also couldn't have speculatively loaded it.
>
> Now, x86 doesn't really do per-cpu page tables easily (otherwise we'd
> have done them ages ago) and doing them is going to be *major* surgery
> and pain.
>
> Other than that, we must take the TLBI-IPI when freeing
> page-table-pages.
>
>
> But yeah, I think Nadav is right, vmalloc.c never frees page-tables (or
> at least, I couldn't find it in a hurry either), but if we're going to
> be doing this, then that file must include a very prominent comment
> explaining it must never actually do so either.
>

I also couldn't find any freeing of the page-table-pages, I'll do another
pass and sharpen my quill for a big fat comment.

> Not being able to free page-tables might be a 'problem' if we're going
> to be doing more of HUGE_VMALLOC, because that means it becomes rather
> hard to swizzle from small to large pages.

