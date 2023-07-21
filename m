Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B8FBEB64DC
	for <rcu@archiver.kernel.org>; Fri, 21 Jul 2023 17:14:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbjGURO5 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 21 Jul 2023 13:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbjGUROz (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 21 Jul 2023 13:14:55 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5E71171B
        for <rcu@vger.kernel.org>; Fri, 21 Jul 2023 10:14:53 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2b702319893so32786621fa.3
        for <rcu@vger.kernel.org>; Fri, 21 Jul 2023 10:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1689959692; x=1690564492;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9K5VHhZFEzQffhn522CBvGHgBcaIDvu9FEQtTEAlvh8=;
        b=v9suOoHBlIk67EKDKPqWLhrvssc3VmdYen5EzwX5m/TcUyTOkr+Ok1N1Qaa2m2hhVU
         dqHw3CQNBMJ741j1Q41aKPaQP8tzE+Ad/rNDqGHrMjkShpnw72khf+y+t5siZc4LowW8
         oTLzbsiQo87tyS4+gTUmElWm6wi61LFe0O8IY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689959692; x=1690564492;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9K5VHhZFEzQffhn522CBvGHgBcaIDvu9FEQtTEAlvh8=;
        b=GNZ/7vVbcgggn2C3my0ijlT+T+we2zJ9/zaxCQwm+x7OVKrLpUswWzLh4cib3dF6rl
         R5XQUy/yOs1XgdSMbD5ae0jfvTmz5Q2gLKXHVdsV2Zl92spfuIeq8cHpG8eTMZ2ZjWQy
         LYdium5RN+eLTb4lhUTxfiimeeWYx6sVXijO+IFuPBguEG687fdYFDOESsLXHFbW/Mty
         iCLSmu88ajyMFWz73sJ3QGtJU3qJi1LeAFRcwf2khPdTTT9bK3/wGiFWs+XnYUPTpLhY
         udKNY0qfJXLcW1ltFTD26BvrkbOH6FzF8qx0WbuTFEbqDVr2wipBniqJhNBCMpN800jm
         rPzA==
X-Gm-Message-State: ABy/qLYXdo9tNp5ERUnGoLWxXoHUc4flwVEkc1qd5oiNOzKlVrMjrSbP
        20u1fhQU/Zao4129rXiiON0bv8Mq1SmgAvjkUBkV1w==
X-Google-Smtp-Source: APBJJlFcu8j3/DkgCopyZdnnpMfBq1CbxSvKbDwtsMsSsOQpSDKDCSmQi43l3aGLy2W0gXu1smDknxyIQxjYzck0H0o=
X-Received: by 2002:a05:651c:205:b0:2b5:9f54:e290 with SMTP id
 y5-20020a05651c020500b002b59f54e290mr1980021ljn.0.1689959691909; Fri, 21 Jul
 2023 10:14:51 -0700 (PDT)
MIME-Version: 1.0
References: <E9CF24C7-3080-4720-B540-BAF03068336B@gmail.com>
 <1E0741E0-2BD9-4FA3-BA41-4E83315A10A8@joelfernandes.org> <1AF98387-B78C-4556-BE2E-E8F88ADACF8A@gmail.com>
 <cc9b292c-99b1-bec9-ba8e-9c202b5835cd@joelfernandes.org> <962bb2b940e64e7da7b71d11b307defc@AcuMS.aculab.com>
In-Reply-To: <962bb2b940e64e7da7b71d11b307defc@AcuMS.aculab.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Fri, 21 Jul 2023 13:14:40 -0400
Message-ID: <CAEXW_YS_raHUrvVAFPpnhL2PRH0hkcqT=1hD+gQOg_cMLkGrjQ@mail.gmail.com>
Subject: Re: Question about the barrier() in hlist_nulls_for_each_entry_rcu()
To:     David Laight <David.Laight@aculab.com>
Cc:     Alan Huang <mmpgouride@gmail.com>,
        Eric Dumazet <edumazet@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "roman.gushchin@linux.dev" <roman.gushchin@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Jul 21, 2023 at 11:59=E2=80=AFAM David Laight <David.Laight@aculab.=
com> wrote:
>
> ....
> > Right, it shouldn't need to cache. To Eric's point it might be risky to=
 remove
> > the barrier() and someone needs to explain that issue first (or IMO the=
re needs
> > to be another tangible reason like performance etc). Anyway, FWIW I wro=
te a
> > simple program and I am not seeing the head->first cached with the patt=
ern you
> > shared above:
> >
> > #include <stdlib.h>
> >
> > #define READ_ONCE(x) (*(volatile typeof(x) *)&(x))
> > #define barrier() __asm__ __volatile__("": : :"memory")
> >
> > typedef struct list_head {
> >      int first;
> >      struct list_head *next;
> > } list_head;
> >
> > int main() {
> >      list_head *head =3D (list_head *)malloc(sizeof(list_head));
> >      head->first =3D 1;
> >      head->next =3D 0;
> >
> >      READ_ONCE(head->first);
> >      barrier();
> >      READ_ONCE(head->first);
> >
> >      free(head);
> >      return 0;
> > }
>
> You probably need to try harder to generate the error.
> It probably has something to do code surrounding the
> sk_nulls_for_each_rcu() in the ca065d0c^ version of udp.c.
>
> That patch removes the retry loop - and probably breaks udp receive.
> The issue is that sockets can be moved between the 'hash2' chains
> (eg by connect()) without being freed.

I was just replying to Alan's question on the behavior of READ_ONCE()
since I myself recently got surprised by compiler optimizations
related to it. I haven't looked into the actual UDP code.

 - Joel
