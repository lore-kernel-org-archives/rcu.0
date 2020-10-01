Return-Path: <SRS0=4XKx=DI=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09891C4727C
	for <rcu@archiver.kernel.org>; Thu,  1 Oct 2020 10:15:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC4E82137B
	for <rcu@archiver.kernel.org>; Thu,  1 Oct 2020 10:15:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AK9x/1EH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731548AbgJAKPw (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 1 Oct 2020 06:15:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbgJAKPw (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 1 Oct 2020 06:15:52 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05397C0613D0;
        Thu,  1 Oct 2020 03:15:52 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id m5so5874341lfp.7;
        Thu, 01 Oct 2020 03:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yP779foQVZTd7hBfYzc8x5HVVPD9H4ll26i7mjT38To=;
        b=AK9x/1EH5gmexWNak1NPEzY9C74BazOc3JDXGwjqNUYcPD0WRVvwvO7XyOuJe1igMR
         PDhTED3odbMFCjTZgn+J4TmZoeMRwBWYMDn0RuEYqTkUivByeORR1sdQL7sm33qgxStO
         FHxypX75VqTWUPh7OIpG7ePL+TPvgkQb4i6hnnTZK6eGOvYJIEoMLG4Cr9J6zuen0oYR
         tcaya7K8VMxi1iUfDFtpa7JfMOwxH9VirfJJqaqVCus3De3e5Qe0AYweZ5jaAaC6jg1R
         AG+hBeq3eyXohdJAK7/rft0pIHE1kDo6K9BjWDzK0K9lXs9bXQsm3saY9kQyF3Aq1V9t
         0lEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yP779foQVZTd7hBfYzc8x5HVVPD9H4ll26i7mjT38To=;
        b=baGV7E+LNZPascItAc6K/8QRsFaoPPzdzB3pl9UM/E/me1c3A/WJlPl9rKJklchgKZ
         4DjMHf2seP5FwJ+0lkk4/3f5+v4a1xUB+03yRLwU48Fz3loO5oVeXS5wLUlTcyyf5Pqc
         9SQrAsCHNXLNgGxqlh//wKwAFWQj6oFBmnuj8tda/SvD0jsarfVqMLAyenykpSHHLPEq
         TDJKzEm/24x8k7k0qYlhnTl2xCd80qw6DAne2KFop/2GweYvs/rXh4fYCPoRZeSSn4h0
         +ccexyAIb5oCeU4GuwzerZS4f9iCIrFB/PUtkE8oDetnAKbUzLcmv4B1R4MaHAlb3zjW
         KavA==
X-Gm-Message-State: AOAM530wQPyzZW4dycsF/obFVT74gjnm6bElEWsTRVZm/F9eapkx2QOS
        Dgt9083rIa3UCGoKp6zB/q9+tDeDbn8BgwY5qeA=
X-Google-Smtp-Source: ABdhPJzE0B3XYSFoxxWCoIujQIlIrX0GFgwGjx6ozGWiaiVey1qgI0/wjkOI3kDNFY6QX+0v9OhDOWTJ77VtvbMwoNk=
X-Received: by 2002:a19:7e8d:: with SMTP id z135mr2532283lfc.158.1601547350476;
 Thu, 01 Oct 2020 03:15:50 -0700 (PDT)
MIME-Version: 1.0
References: <CAKwvOd=s+N4+X94sTams_hKn8uV5Hc6QyCc7OHyOGC-JFesS8A@mail.gmail.com>
 <20200929192549.501516-1-ndesaulniers@google.com> <CA+icZUVgfnVQ1=zjUGhGKnJAs9g3Q06sWN3ffNdrfZMZLCEkbA@mail.gmail.com>
 <133589afbe999347454dfcc46ae782897bf9e3a2.camel@perches.com>
 <46f69161e60b802488ba8c8f3f8bbf922aa3b49b.camel@perches.com>
 <CAKwvOdkhyvTpY6pHT+CLSsBFuKRWsXucjbwN_tyJAsryZXvG1A@mail.gmail.com>
 <417ffa3fd3fba5d4a481db6a0b0c9b48cbbb17c4.camel@perches.com>
 <CAKwvOd=P+j0RaQfHsXPfB0EL3oRgAu8Q0+spUOn_v-p2+3=3pw@mail.gmail.com>
 <aefe941251d5d58062d06099afb58dea1d1d4e17.camel@perches.com> <46040e2776a4848add06126ce1cb8f846709294f.camel@perches.com>
In-Reply-To: <46040e2776a4848add06126ce1cb8f846709294f.camel@perches.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 1 Oct 2020 12:15:39 +0200
Message-ID: <CANiq72mSjs4myQQtUoegjRggjTx9UF70nAcWoXRoTeLMOuf0xQ@mail.gmail.com>
Subject: Re: [RFC PATCH next-20200930] treewide: Convert macro and uses of
 __section(foo) to __section("foo")
To:     Joe Perches <joe@perches.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>, rcu@vger.kernel.org,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hi Joe,

On Thu, Oct 1, 2020 at 12:56 AM Joe Perches <joe@perches.com> wrote:
>
> So I installed the powerpc cross compiler, and
> nope, that doesn't work, it makes a mess.

Thanks a lot for reviving the script and sending the treewide cleanup!

> So it looks like the best option is to exclude these
> 2 files from conversion.

Agreed. Nevertheless, is there any reason arch/powerpc/* should not be
compiling cleanly with compiler.h? (CC'ing the rest of the PowerPC
reviewers and ML).

Cheers,
Miguel
