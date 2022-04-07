Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA31EC433EF
	for <rcu@archiver.kernel.org>; Thu,  7 Apr 2022 23:14:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232378AbiDGXQf (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 7 Apr 2022 19:16:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbiDGXQf (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 7 Apr 2022 19:16:35 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5411F13BAD8
        for <rcu@vger.kernel.org>; Thu,  7 Apr 2022 16:14:33 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id r13so13926770ejd.5
        for <rcu@vger.kernel.org>; Thu, 07 Apr 2022 16:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hCyVboVUMPZRo6TCLUWM5ite4XgyvgGmMlQpKKqCowA=;
        b=GrG2qMP7peJK3yh7+RDthSYJ//So1IVDy9vGbZMtlQFpxCmwpcOKLT14mMaqvCS6c8
         pezqIjuxHzZWIWU3siGlmijZpUfQ+Dy8DElqN9hElT4anUAl59t77HSjafgUBAhS8FD6
         m8mtbLejgIab93m+4ta3CFenMUsh/9GP32voxnMvmmyJ+/GDlnxcZge0vO8X/rZ0X/4y
         j6K6RaVe2VFyZpjAGJv3W2rxTC8WER+9XNRvE41rC50VroN7EiHthsMuu7p+KzpdqzVo
         db2Ti/gJhCIqi3/CbvkE8lnQpV1NQk/OtdCY4YULljzJOQjjDKMAZRqJoy9QzXed8p6n
         7mYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hCyVboVUMPZRo6TCLUWM5ite4XgyvgGmMlQpKKqCowA=;
        b=iBYUq+3BAkUhotvTOgWdSoWrnyLRIuERTQeUgmh4RqtDxMdDgQULKIVWricmxiMayO
         9R2HUAABFSV2ywAEuxvORPNAaBCJMfPtD8glNPosXOb4rwe4GF/cx6piG14+qvGxD3T7
         27hkQyUFKOFSVW9zel5u3+f/su9U+rApxCWrAZrI8+BNvrAtRqTVVSi+KfTUoKDaQe3j
         S6qUVvnH7tRT8V6CgUe+TGyvbHMHZ6gaT5C8fM8/Ncco31cS6eVkARtk/jPCrV8JuL2K
         BM0dGkW0mCdx8NysGRdSr2j6kos8Rr0WqLMiBhnfFH0gDlxbul/5jF4ZdTYdUUAdf8z5
         0nlw==
X-Gm-Message-State: AOAM530G8+wdQivfAXhvwHyp35Bqj2spMfplo86gLmobuaglJeEwwuaQ
        yLNXuR110WBj7u5Y2qv3Qtd/jfINo2/X8J6BP5g=
X-Google-Smtp-Source: ABdhPJx5uiKTVZj1SoMAR7GkPqFXPjtVnFlop1C4TgW0U9VAY3y3a03KwRCCZhzWJ1jeAPhX3Pa6hDNtJFuPZQ3NNoE=
X-Received: by 2002:a17:907:6d07:b0:6e7:979e:9c0a with SMTP id
 sa7-20020a1709076d0700b006e7979e9c0amr15502794ejc.614.1649373271786; Thu, 07
 Apr 2022 16:14:31 -0700 (PDT)
MIME-Version: 1.0
References: <CANiq72k+5Rdj7i3Df2dcE6_OPYPXK3z5EWLKnY56sSMz4G3OvA@mail.gmail.com>
 <CAABZP2z64aYWfVSdXHaQopWc+BAbJJUGqtrju2iWER3DDTDFWg@mail.gmail.com>
 <20220406170012.GO4285@paulmck-ThinkPad-P17-Gen-1> <CAABZP2zhZaN0+KqP7oMoyXTSkDhLjZwWvnj7coa1ZVve9M+jsQ@mail.gmail.com>
 <20220406195011.GP4285@paulmck-ThinkPad-P17-Gen-1> <CAABZP2x8_783jhEhC3AozH9=xj40UO-rZT2BRJsg5gaLdBz=9w@mail.gmail.com>
 <CANiq72mYXnQo_Y39k23rY-rdJay8GEPJ8MhU-y7-bjkw=zRC+Q@mail.gmail.com>
 <20220407151555.GR4285@paulmck-ThinkPad-P17-Gen-1> <CANiq72k7BWjOU8=-dXD4bYWbK1i+rjDNaAohGrU42yJzcBm7uQ@mail.gmail.com>
 <20220407175500.GV4285@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20220407175500.GV4285@paulmck-ThinkPad-P17-Gen-1>
From:   Zhouyi Zhou <zhouzhouyi@gmail.com>
Date:   Fri, 8 Apr 2022 07:14:20 +0800
Message-ID: <CAABZP2yDe3dU0DtigvAE4CQLAipvT81Bw4LrF5WjLSiP5nq1UA@mail.gmail.com>
Subject: Re: rcu_sched self-detected stall on CPU
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        rcu <rcu@vger.kernel.org>, Zhouyi Zhou <zhouzhouyi@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Dear Paul and Miguel

On Fri, Apr 8, 2022 at 1:55 AM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Thu, Apr 07, 2022 at 07:05:58PM +0200, Miguel Ojeda wrote:
> > On Thu, Apr 7, 2022 at 5:15 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> > >
> > > Ah.  So you would instead look for boot to have completed within 10
> > > seconds?  Either way, reliable automation might well more important than
> > > reduction in time.
> >
> > No (although I guess that could be an option), I was only pointing out
> > that when no stall is produced, the run should be much quicker than 30
> > seconds (at least it was in my setup), which would be the majority of the runs.
>
> Ah, thank you for the clarification!
Thank both of you for the information. In my setup (PPC cloud VM), the
majority of the runs complete at least for 50 seconds. From last
evening to this morning (Beijing Time), following experiments have
been done:
1) torture mainline: the test quickly finished by hitting "rcu_sched
self-detected stall" after 12 runs
2) torture v5.17: the test last 10 hours plus 14 minutes, 702 runs
have been done without trigger the bug

Conclusion:
There must be a commit that causes the bug as Paul has pointed out.
I am going to do the bisect, and estimate to locate the bug within a
week (at most).
This is a good learning experience, thanks for the guidance ;-)

Kind Regards
Zhouyi
>
>                                                         Thanx, Paul
