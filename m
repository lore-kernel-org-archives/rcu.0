Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAAC7C04A6A
	for <rcu@archiver.kernel.org>; Fri, 21 Jul 2023 07:59:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbjGUH7v (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 21 Jul 2023 03:59:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbjGUH7r (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 21 Jul 2023 03:59:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD7322704
        for <rcu@vger.kernel.org>; Fri, 21 Jul 2023 00:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689926338;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OMiNfezuDp8QZVlAhLlbiIMuGymmCNYB2I4q0EEFUSk=;
        b=es9VMHsiDg2kuJVCMyTCvHzFaAuKoWL4QN9LjBQxFyxYc2fjsb2ogQ78VCKuGxIJAwnq9u
        u3eXDF1fgpsBDz13/yue0Z+cwF00LhcZnXJYCXZZky1FsICn2cuMzs7vHFE+EhMfimzW4p
        xEMc+hIL3o4dp33wXsBxVpL70l3Saic=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-8-FDHdC72uOdazp-vxz1EhIw-1; Fri, 21 Jul 2023 03:58:57 -0400
X-MC-Unique: FDHdC72uOdazp-vxz1EhIw-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-314291caa91so874457f8f.2
        for <rcu@vger.kernel.org>; Fri, 21 Jul 2023 00:58:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689926336; x=1690531136;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OMiNfezuDp8QZVlAhLlbiIMuGymmCNYB2I4q0EEFUSk=;
        b=NP4HVYWOUVJ4Qazh9jWmweZOIQBsrDiimTzrlA2jchbAhMNkvVn5G3YtlMbXQwp9At
         0Blw2EoYCLrQp4+NPp9YCUTiVCEB+r/gE733c4KmZ5F7mltTfSXTcjnqjBU0gHakLnim
         JQBCp+xGzWPMxGxytCHQcy4Y94Aj3H8NKc7GvENHQP5hcvUjDmBqKWH6JPJKmAIWR7Fw
         y1REVD9X9UerAmCRhDyNqLEzLzD2MvHLaNpFS39BO/32RVkrvXEMdbO5ImtoBNmEbXID
         Ugpf9qZ+YOhv/HZkpiWhGPQojJ1Bw1xNXSPhUOarg4uk7SiLwaggUCts+CosA7XT/fqP
         liRQ==
X-Gm-Message-State: ABy/qLaBCVKD2tQ5XE+1PSf+R/3qlZFn0ee6SYBLZjA+1OIqKz1OQNeY
        bM0/6h82M/3uULAllPRK2Ns14XOKm/acMLUdQbrlRHqNN4Yc+bIQ4s8a0CdCyVt99uFmDQ6RXGY
        +FQ4i/p0X6/Fn
X-Received: by 2002:a5d:6103:0:b0:313:e559:2d4c with SMTP id v3-20020a5d6103000000b00313e5592d4cmr798836wrt.45.1689926336423;
        Fri, 21 Jul 2023 00:58:56 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHidrlV6ut/P6AGZyG//+hfTFRQfLD41RE3t6gFtW0P8dq2RF0fuunZIegUj7e2SS5Snlr4dg==
X-Received: by 2002:a5d:6103:0:b0:313:e559:2d4c with SMTP id v3-20020a5d6103000000b00313e5592d4cmr798794wrt.45.1689926336070;
        Fri, 21 Jul 2023 00:58:56 -0700 (PDT)
Received: from vschneid.remote.csb ([149.12.7.81])
        by smtp.gmail.com with ESMTPSA id i7-20020a05600011c700b00313fd294d6csm3510472wrx.7.2023.07.21.00.58.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 00:58:55 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     paulmck@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org,
        bpf@vger.kernel.org, x86@kernel.org, rcu@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
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
        Frederic Weisbecker <frederic@kernel.org>,
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
Subject: Re: [RFC PATCH v2 17/20] rcutorture: Add a test config to torture
 test low RCU_DYNTICKS width
In-Reply-To: <5143d0a9-bc02-4b9a-8613-2383bfdee35c@paulmck-laptop>
References: <20230720163056.2564824-1-vschneid@redhat.com>
 <20230720163056.2564824-18-vschneid@redhat.com>
 <24b55289-1c35-41cc-9ad3-baa957f1c9cb@paulmck-laptop>
 <5143d0a9-bc02-4b9a-8613-2383bfdee35c@paulmck-laptop>
Date:   Fri, 21 Jul 2023 08:58:53 +0100
Message-ID: <xhsmhmszpu24i.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On 20/07/23 21:00, Paul E. McKenney wrote:
> On Thu, Jul 20, 2023 at 12:53:05PM -0700, Paul E. McKenney wrote:
>> On Thu, Jul 20, 2023 at 05:30:53PM +0100, Valentin Schneider wrote:
>> > diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TREE11 b/tools/testing/selftests/rcutorture/configs/rcu/TREE11
>> > new file mode 100644
>> > index 0000000000000..aa7274efd9819
>> > --- /dev/null
>> > +++ b/tools/testing/selftests/rcutorture/configs/rcu/TREE11
>> > @@ -0,0 +1,19 @@
>> > +CONFIG_SMP=y
>> > +CONFIG_NR_CPUS=8
>> > +CONFIG_PREEMPT_NONE=n
>> > +CONFIG_PREEMPT_VOLUNTARY=y
>> > +CONFIG_PREEMPT=n
>> > +CONFIG_PREEMPT_DYNAMIC=n
>> > +#CHECK#CONFIG_TREE_RCU=y
>> > +CONFIG_HZ_PERIODIC=n
>> > +CONFIG_NO_HZ_IDLE=n
>> > +CONFIG_NO_HZ_FULL=y
>> > +CONFIG_RCU_TRACE=y
>> > +CONFIG_RCU_FANOUT=4
>> > +CONFIG_RCU_FANOUT_LEAF=3
>> > +CONFIG_DEBUG_LOCK_ALLOC=n
>> > +CONFIG_DEBUG_OBJECTS_RCU_HEAD=n
>> > +CONFIG_RCU_EXPERT=y
>> > +CONFIG_RCU_EQS_DEBUG=y
>> > +CONFIG_RCU_LAZY=y
>> > +CONFIG_RCU_DYNTICKS_BITS=2
>>
>> Why not just add this last line to the existing TREE04 scenario?
>> That would ensure that it gets tested regularly without extending the
>> time required to run a full set of rcutorture tests.
>
> Please see below for the version of this patch that I am running overnight
> tests with.  Does this one work for you?
>

Yep that's fine with me. I only went with a separate test file as wasn't
sure how new test options should be handled (merged into existing tests vs
new tests created), and didn't want to negatively impact TREE04 or
TREE06. If merging into TREE04 is preferred, then I'll do just that and
carry this path moving forwards.

Thanks!

