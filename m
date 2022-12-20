Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2DC4C4332F
	for <rcu@archiver.kernel.org>; Tue, 20 Dec 2022 04:07:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232394AbiLTEHd (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 19 Dec 2022 23:07:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiLTEHb (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 19 Dec 2022 23:07:31 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19EC138B5
        for <rcu@vger.kernel.org>; Mon, 19 Dec 2022 20:07:30 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id f34so1551718lfv.10
        for <rcu@vger.kernel.org>; Mon, 19 Dec 2022 20:07:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qDu+2HB9LCelBr6OwQ3TS8ifZcPH8YwgroAjWq1C00k=;
        b=Y86xtdv3XMJ+nN6oow1JLrJgBuF3civOC/ytVGb1nq+LnnsmCdw6yZQ1wsodZHZu+h
         ln3X2He+1mz1o7S8y46L4rQlGaYaBQ3m+ZhGRpa0x2Dr6YQUhUY/Or9zntk/NTPI0NQ4
         QIH1W0OWhRa+DH724vkVR9Fb504i+gqDmStIQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qDu+2HB9LCelBr6OwQ3TS8ifZcPH8YwgroAjWq1C00k=;
        b=dVw3A/eCZ/sVbVSExfRPY5pXeAgbk6x6OwgsbUJ6UHFA0tSgoxf6aZHdAYc0GRjMXp
         FibIQoqq//2ZZiBEcOiya07DRKvnRymvYPHb0L8kuLDx5gIuiFF06/m3Up4cMgXLFJo1
         qgtEM/xKW9D71eugGqgOq+DD04Elonnoy9jSXyugEtpDvWdZ+PwgrkGgmpbF5/1uHuEo
         ymMf8jlSxwHui/myaKlgPl6LjXrXFuHN0Bekaevp2IBM92/Geh1rFUFqB3VlbXRxUBjn
         wRTiBv6kogXqB4HggSIGeHpoOR9IVsVz+bJe60Jqbze53/8XDgBNTBwV551n4ZuDW2mZ
         Phkg==
X-Gm-Message-State: ANoB5pmItnNxnYgwtOFN6HAYvOA0fgkKnAJhkmtBKoMKaQlwKn4QF+NH
        buZaGfboWx0nkhc44hsEmxhGFBKz1JwiTpuMf4CUXQ==
X-Google-Smtp-Source: AA0mqf6VnHU/0i+jLya+GHkKML+2c0Byt6jC+vJK2QzrSvQpzsNLCtjhYeKCE9zL7w5NgiRdEhGskhzdRPYMZSBcSdU=
X-Received: by 2002:a05:6512:224c:b0:4b5:ad89:8174 with SMTP id
 i12-20020a056512224c00b004b5ad898174mr3579330lfu.84.1671509248402; Mon, 19
 Dec 2022 20:07:28 -0800 (PST)
MIME-Version: 1.0
References: <20221218191310.130904-1-joel@joelfernandes.org>
In-Reply-To: <20221218191310.130904-1-joel@joelfernandes.org>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Mon, 19 Dec 2022 23:07:17 -0500
Message-ID: <CAEXW_YRjAsx0HCnmjvth+yi0COTiynPRvjyT2sf1utMw5bTgiw@mail.gmail.com>
Subject: Re: [RFC 0/2] srcu: Remove pre-flip memory barrier
To:     linux-kernel@vger.kernel.org
Cc:     Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sun, Dec 18, 2022 at 2:13 PM Joel Fernandes (Google)
<joel@joelfernandes.org> wrote:
>
> Hello, I believe the pre-flip memory barrier is not required. The only reason I
> can say to remove it, other than the possibility that it is unnecessary, is to
> not have extra code that does not help. However, since we are issuing a fully
> memory-barrier after the flip, I cannot say that it hurts to do it anyway.
>
> For this reason, please consider these patches as "informational", than a
> "please merge". :-) Though, feel free to consider merging if you agree!
>
> All SRCU scenarios pass with these, with 6 hours of testing.
>
> thanks,
>
>  - Joel
>
> Joel Fernandes (Google) (2):
> srcu: Remove comment about prior read lock counts
> srcu: Remove memory barrier "E" as it is not required

And litmus tests confirm that "E" does not really do what the comments
say, PTAL:
Test 1:
C mbe
(*
 * Result: sometimes
 * Does previous scan see old reader's lock count, if a new reader saw
the new srcu_idx?
 *)

{}

P0(int *lockcount, int *srcu_idx) // updater
{
        int r0;
        r0 = READ_ONCE(*lockcount);
        smp_mb();       // E
        WRITE_ONCE(*srcu_idx, 1);
}

P1(int *lockcount, int *srcu_idx) // reader
{
        int r0;
        WRITE_ONCE(*lockcount, 1); // previous reader
        smp_mb();       // B+C
        r0 = READ_ONCE(*srcu_idx); // new reader
}
exists (0:r0=0 /\ 1:r0=1) (* Bad outcome. *)

Test 2:
C mbe2

(*
 * Result: sometimes
 * If updater saw reader's lock count, was that reader using the old idx?
 *)

{}

P0(int *lockcount, int *srcu_idx) // updater
{
        int r0;
        r0 = READ_ONCE(*lockcount);
        smp_mb();       // E
        WRITE_ONCE(*srcu_idx, 1);
}

P1(int *lockcount, int *srcu_idx) // reader
{
        int r0;
        int r1;
        r1 = READ_ONCE(*srcu_idx); // previous reader
        WRITE_ONCE(*lockcount, 1); // previous reader
        smp_mb();       // B+C
        r0 = READ_ONCE(*srcu_idx); // new reader
}
exists (0:r0=1 /\ 1:r1=1) (* Bad outcome. *)

thanks,

 - Joel


>
> kernel/rcu/srcutree.c | 10 ----------
> 1 file changed, 10 deletions(-)
>
> --
> 2.39.0.314.g84b9a713c41-goog
>
