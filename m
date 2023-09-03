Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B92AEC83F3F
	for <rcu@archiver.kernel.org>; Sun,  3 Sep 2023 00:10:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235344AbjICAKc (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sat, 2 Sep 2023 20:10:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235316AbjICAKb (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sat, 2 Sep 2023 20:10:31 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDF28CE0
        for <rcu@vger.kernel.org>; Sat,  2 Sep 2023 17:10:26 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2bcc14ea414so3819941fa.0
        for <rcu@vger.kernel.org>; Sat, 02 Sep 2023 17:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1693699825; x=1694304625; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yFEmQ5kXTPv/inXJCJuXQh0sse6fWjwxLcH/69wCU2A=;
        b=IUHnMsKXpm4QaSfCpBNqbxRDoBTIMO97y6O1fzgbn/pVC2LZXHubpkm//jv/VNGAU5
         YgypOa5B7JhnZZoaBjftg2WzNigsJgsqPrZ5CafQETTk2hP4JLASoK/02897aWNGk6L/
         KyWIhbuzYdoLy0BZ4duXQ82Kq4L4XSikaWEpo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693699825; x=1694304625;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yFEmQ5kXTPv/inXJCJuXQh0sse6fWjwxLcH/69wCU2A=;
        b=iPfUeEQvn27PbGXJJwe91N8cBrX+77SrjHLOZmj3KDUgaShWFUpiaHhZLN0YYYBtKm
         c4S1z5d4hNlz7ltjg3C+KIo+DEZwl/h6ktbFzh6pqHBlg2PUlOnBZAEbnDJqWpslndqv
         fcVwsUGZYKV+jwQA5eeMe68nzK1C48wXODsGZCKbwxE+O/NtliSybixNrjPls5QP3Tbv
         vGN+PrfZQsSi3CjD3R7nEAolcQD0+VsTQY2Vda/eDNLujAVHFuSNfstiV5TPs9tZXOKo
         4xEjOTqr49qV1i/8/l9MRUQnHpvn+XoAyNtBMqjs9tquYpY7WeI6QXW24XYbX9KH7gER
         j+DA==
X-Gm-Message-State: AOJu0YxHXwoVzCtIKi+ugxNuP2ir/nqWMsUAKGTYJcEPR8zgwyGDoqCG
        uUnrAFr8M7ns3wRpuGaLLlcwQ3NC64wNqeJR2kFXYQ==
X-Google-Smtp-Source: AGHT+IEOmuXCm8JpDX8x7VbtsPFVgZ7bN6WpGy/rT/Z2VfD1BjviniJqmhx1rCmQUt8GoNIA+FU0izXJWXZQzp2AfUs=
X-Received: by 2002:a2e:95d7:0:b0:2bc:e330:660b with SMTP id
 y23-20020a2e95d7000000b002bce330660bmr4401290ljh.9.1693699825007; Sat, 02 Sep
 2023 17:10:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230831012257.1189964-1-joel@joelfernandes.org>
 <b292cca4-d451-4371-ae2e-9417e0079e84@paulmck-laptop> <CAEXW_YRa0Gd2Gt8LagAyOp_8VwT+ra3N4+DBquUNn_Xmo8o7eg@mail.gmail.com>
 <7bd77573-ded1-432e-8008-4c1cbe1b9eb9@paulmck-laptop> <CAEXW_YTzP90zs8z4UFC52fd_KMkpBba6ujBNnDM5Z6exskJ6tg@mail.gmail.com>
 <e0977773-de90-42bb-a67d-dc16d24764a3@paulmck-laptop>
In-Reply-To: <e0977773-de90-42bb-a67d-dc16d24764a3@paulmck-laptop>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Sat, 2 Sep 2023 20:10:13 -0400
Message-ID: <CAEXW_YSukJ_SSvy731iF9WZ5N9cycHsfzdz+8MKA4Va+1+FW4A@mail.gmail.com>
Subject: Re: [PATCH] rcu/torture: Improve badness extraction from console logs
To:     paulmck@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Shuah Khan <shuah@kernel.org>, rcu@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sat, Sep 2, 2023 at 3:24=E2=80=AFPM Paul E. McKenney <paulmck@kernel.org=
> wrote:
>
[...]
> > > Either way, what I don't want is many megabytes of splats from consol=
e.log
> > > duplicated into console.log.diags, especially in those (admittedly sa=
d)
> > > cases where the console.log file is the largest file in the results
> > > directory.  Are you really going to be reading carefully after (say)
> > > the fifth splat?  ;-)
> >
> > I could limit it to just the first 5, with the existing unlimited
> > summary at the top.
>
> How about limiting the existing summary to (say) 10 lines?  I do not
> recall every caring about more than that.  The only reason that I did
> not ever limit it myself is that the summary is unlikely to be more than
> a few percent of the full console.log.
>
> > Let me know if that works or does not work for you. :-)
>
> I do believe that we might be converging.  ;-)

Ok, so 10 lines of summary (similar to existing), and 10 detailed
splats below that :-).  If that's not Ok, let me know. Otherwise I
will send the new patch soon. Thanks!

 - Joel
