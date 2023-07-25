Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90683C41513
	for <rcu@archiver.kernel.org>; Tue, 25 Jul 2023 13:38:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231202AbjGYNiL (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 25 Jul 2023 09:38:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231207AbjGYNiJ (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 25 Jul 2023 09:38:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECE171BC3
        for <rcu@vger.kernel.org>; Tue, 25 Jul 2023 06:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690292233;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YuHDDSh+hqntXfEBDTeZy9lkclJmyfPYzRYLt1ff+f8=;
        b=D+Py+Dz7QtVFbXp+d+7w+d4ly9UsAicqh8rLFTGaF2dMyGXOYCp0CcCF0WAg7PDCdy1afF
        +DbHSQtnNscCM6BczQZKFD+YXh7CWzjd7Fy9OoFCVprNCJgqb3oA2cRkBqtWpkOrPbC+tO
        4vFw5xBJ5SDaHYNfo8sSACNMhmLSnoU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-QcXYkNZiMgS4g4UgsUTb4w-1; Tue, 25 Jul 2023 09:37:09 -0400
X-MC-Unique: QcXYkNZiMgS4g4UgsUTb4w-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-31421c900b7so3258196f8f.3
        for <rcu@vger.kernel.org>; Tue, 25 Jul 2023 06:37:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690292223; x=1690897023;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YuHDDSh+hqntXfEBDTeZy9lkclJmyfPYzRYLt1ff+f8=;
        b=N41NMcc0sLqwh6xqZen7AEvyjkHeR6Ve1Q3IifTkF+lYuF2d1PxQ1tNRcNCj5T9tMI
         tsLkmF5yfB9U2Old4ebLyGHmF2GMNBM0j6NKofVQT9GjUMGaZQYNe/0e7ThoXT7UzKxB
         ia8K34P/k2YFOtMoPUOtNXxrMilXJYQdMj2i77cs0CeNg6zvPx9p0V7u0ww5yfSsJvGU
         8gZqymbHE4LJxxx51UWzgyKAupLuE0I5gqLKmdMRmn86SpebxBhPyeqLAfSWJRXKxT5M
         UrfpKErYlFI7nCZw5Rz/bHpaTOtsxGXuhbHdSRztLubxL64yKYzOIuiS9k3PVmzNpFZI
         5AvQ==
X-Gm-Message-State: ABy/qLYP+ED2Gb/yIxP2tGdLFbKquwgbgMrh/0NNylzQg/Xlt+kB0xD5
        htFkfSb7nc0CF/jqd7APAzNChI7Ib2TX6VrXal39GTovjFhAyS4uB4xlLtXsSFKJkWUf9trKtWx
        1rnI+XstsL/8N
X-Received: by 2002:adf:edd1:0:b0:313:df09:ad04 with SMTP id v17-20020adfedd1000000b00313df09ad04mr11718232wro.57.1690292223003;
        Tue, 25 Jul 2023 06:37:03 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEu1q96uzpYLmrQ6ZyLxOIliHI6bjUjLVOksOKXP2KWpblMNlkbQak2J3cKJncV5JGWmoXhZA==
X-Received: by 2002:adf:edd1:0:b0:313:df09:ad04 with SMTP id v17-20020adfedd1000000b00313df09ad04mr11718201wro.57.1690292222669;
        Tue, 25 Jul 2023 06:37:02 -0700 (PDT)
Received: from vschneid.remote.csb ([149.12.7.81])
        by smtp.gmail.com with ESMTPSA id h3-20020a5d4fc3000000b00314329f7d8asm16390715wrw.29.2023.07.25.06.36.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 06:37:01 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org,
        bpf@vger.kernel.org, x86@kernel.org, rcu@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
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
        Frederic Weisbecker <frederic@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
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
Subject: Re: [RFC PATCH v2 18/20] context_tracking,x86: Defer kernel text
 patching IPIs
In-Reply-To: <6EBAEEED-6F38-472D-BA31-9C61179EFA2F@joelfernandes.org>
References: <20230720163056.2564824-19-vschneid@redhat.com>
 <6EBAEEED-6F38-472D-BA31-9C61179EFA2F@joelfernandes.org>
Date:   Tue, 25 Jul 2023 14:36:59 +0100
Message-ID: <xhsmhtttsru2s.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On 25/07/23 06:49, Joel Fernandes wrote:
> Interesting series Valentin. Some high-level question/comments on this on=
e:
>
>> On Jul 20, 2023, at 12:34 PM, Valentin Schneider <vschneid@redhat.com> w=
rote:
>>
>> =EF=BB=BFtext_poke_bp_batch() sends IPIs to all online CPUs to synchroni=
ze
>> them vs the newly patched instruction. CPUs that are executing in usersp=
ace
>> do not need this synchronization to happen immediately, and this is
>> actually harmful interference for NOHZ_FULL CPUs.
>
> Does the amount of harm not correspond to practical frequency of text_pok=
e?
> How often does instruction patching really happen? If it is very infreque=
nt
> then I am not sure if it is that harmful.
>

Being pushed over a latency threshold *once* is enough to impact the
latency evaluation of your given system/application.

It's mainly about shielding the isolated, NOHZ_FULL CPUs from whatever the
housekeeping CPUs may be up to (flipping static keys, loading kprobes,
using ftrace...) - frequency of the interference isn't such a big part of
the reasoning.

>>
>> As the synchronization IPIs are sent using a blocking call, returning fr=
om
>> text_poke_bp_batch() implies all CPUs will observe the patched
>> instruction(s), and this should be preserved even if the IPI is deferred.
>> In other words, to safely defer this synchronization, any kernel
>> instruction leading to the execution of the deferred instruction
>> sync (ct_work_flush()) must *not* be mutable (patchable) at runtime.
>
> If it is not infrequent, then are you handling the case where userland
> spends multiple seconds before entering the kernel, and all this while
> the blocking call waits? Perhaps in such situation you want the real IPI
> to be sent out instead of the deferred one?
>

The blocking call only waits for CPUs for which it queued a CSD. Deferred
calls do not queue a CSD thus do not impact the waiting at all. See
smp_call_function_many_cond().

