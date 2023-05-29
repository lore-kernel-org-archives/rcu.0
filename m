Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D118CC77B7E
	for <rcu@archiver.kernel.org>; Mon, 29 May 2023 11:30:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231484AbjE2Lad (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 29 May 2023 07:30:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231428AbjE2Laa (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 29 May 2023 07:30:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AADA5BE
        for <rcu@vger.kernel.org>; Mon, 29 May 2023 04:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685359782;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6jQOvr1FoT9F+vm6bP7o3spkjulMXlkn4v1chopkl7w=;
        b=BO1ltJX3F0BDQrwxQXq78COKfpGfcuOj9epOQcGsEOjE9CcPWHhDcVmfLNoiVf3ttvhxyc
        VO2dV5/Yg8v3mWssxcV7jd3dQqjXdYRLkkTCXJmG8fWkeIfJoOyBLRW+yuWpLCCNocXtiH
        LuAxKiHfj9zQX9MGRiWbS4OWHzGOlJ8=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-331-ODmTpcGYOx6ypUjGPY7BIQ-1; Mon, 29 May 2023 07:29:41 -0400
X-MC-Unique: ODmTpcGYOx6ypUjGPY7BIQ-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-970e0152da7so371426066b.2
        for <rcu@vger.kernel.org>; Mon, 29 May 2023 04:29:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685359780; x=1687951780;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6jQOvr1FoT9F+vm6bP7o3spkjulMXlkn4v1chopkl7w=;
        b=AFOXBgS4CacrQl97ZwJRVWTc+s7tCYEbNmd7CNgt2jxAz5nyQ5rolxuyAnDDIqLBe2
         bvZEF6FAj7/htlr78USMiI+mJbvbHpwCCuNn/Nl0A8EXrsBqhvMSgzKN+ajJVLbAMPpI
         ZoqyJuch64gW0Esayx5SaluQ3O0U53IVQCeuSa5+8JqMcmVCrH/0VFthcu0aiPPWE9Kp
         GFWzXL6fNLsYiqBVMS7LYKu/ZE/6gf5RSLy36WO6tu30OxDOxaDbwRiMLjUlMG3xlGik
         dzPPULaNIbDUF8b3WdV/aKZ9ZwmShxo0+xnDmQw5gN1kKQImJPqqrXJw3PdGH8r3QjzW
         iEHQ==
X-Gm-Message-State: AC+VfDyEHGAgYthEoi30cmQ8B9n38dA5ByXXC/CFSkcazVs8/nXzJmJ2
        h9W6vaBXOy+vgZuB4QMaduG4+jdphvAvPi95QYof/TqngYfFNSXsEukrwrsnu8lLwDkivpm/cxz
        swUuLAg2E1P29
X-Received: by 2002:a17:907:701:b0:965:6aff:4f02 with SMTP id xb1-20020a170907070100b009656aff4f02mr11397854ejb.41.1685359780552;
        Mon, 29 May 2023 04:29:40 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ44NKXoCyFgN0hex48Ea3hLzLVI/2blAe40TjmmmtaVCWA1memQAsehlhyyjwO22MVQDW+uqg==
X-Received: by 2002:a17:907:701:b0:965:6aff:4f02 with SMTP id xb1-20020a170907070100b009656aff4f02mr11397814ejb.41.1685359780194;
        Mon, 29 May 2023 04:29:40 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89? ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
        by smtp.googlemail.com with ESMTPSA id gr10-20020a170906e2ca00b0096ace550467sm5885210ejb.176.2023.05.29.04.29.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 May 2023 04:29:39 -0700 (PDT)
Message-ID: <bed45ea4-12e0-5a96-6196-9903b45178f2@redhat.com>
Date:   Mon, 29 May 2023 13:29:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [RFC][PATCH 0/2] Lock and Pointer guards
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>,
        torvalds@linux-foundation.org, keescook@chromium.org,
        gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, ojeda@kernel.org,
        ndesaulniers@google.com, mingo@redhat.com, will@kernel.org,
        longman@redhat.com, boqun.feng@gmail.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, paulmck@kernel.org,
        frederic@kernel.org, quic_neeraju@quicinc.com,
        joel@joelfernandes.org, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        qiang1.zhang@intel.com, rcu@vger.kernel.org, tj@kernel.org,
        tglx@linutronix.de
References: <20230526150549.250372621@infradead.org>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20230526150549.250372621@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On 5/26/23 17:05, Peter Zijlstra wrote:
> My initial (failed) attempts tried to combine __cleanup, _Generic and
> __auto_type, but the compilers refused. I've also Googled around and found
> (among many others) the QEMU and Glib guards. However I don't like them because
> they end up relying on function pointers/indirect calls.
> 
> Hence the current pile of CPP hackery.. no indirect calls in sight.

QEMU's guards in practice also compiles down to direct calls, but yes 
that's only after the compiler inlines everything in the vtable.  I did 
it that way because the polymorphic locks already existed before, 
otherwise your solution with Linus's tweak for "bool" is as nice as it 
can be.  I like that it extends to irqoff and irqsave sections.

Paolo

