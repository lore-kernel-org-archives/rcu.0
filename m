Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA7FDEEB57E
	for <rcu@archiver.kernel.org>; Sun, 10 Sep 2023 23:10:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbjIJXKf (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 10 Sep 2023 19:10:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbjIJXKe (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 10 Sep 2023 19:10:34 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D253184
        for <rcu@vger.kernel.org>; Sun, 10 Sep 2023 16:10:28 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2bd0d135ca3so66667751fa.3
        for <rcu@vger.kernel.org>; Sun, 10 Sep 2023 16:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1694387426; x=1694992226; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=70Wla2Jr3IBJ9uGTryWFTukL34Oe/jHfMXRm6usu/EM=;
        b=iGa9emb6ZEC9WcB70oBijP2LI/LWZYqQblVnH6+sazvVLQoxkY5Ce7LlU81MnL6Lg/
         McjTdtO/scKpKFodBPXcOUpb6sDKOWPEjfl5C1Ks0ZXM+2ucNNMTyiN9pTKcApRoouTR
         EyRkA0pcjzzGtF/iQqdDlbFDVSqtYdDMF+Mxg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694387426; x=1694992226;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=70Wla2Jr3IBJ9uGTryWFTukL34Oe/jHfMXRm6usu/EM=;
        b=vCdJrUHQNBF9KUsRy5DnHUVn+yFd89ETJAP1kfgY14s4rQf8ijQGUnrq++2S1m36Jw
         /98vItIxw88PBNYW9fCveznFdLzAtSSKQYLZvTfwStfNINSrxQYJFuUOsRnBk7gNABfZ
         yP7edyehituh2CYqM6kjCmpXxfwrrhL7wrZeWDTjDhaqntQjQsZTjVhqc74F00cTgj5T
         I1aJ2/76iFWOmnHVMvBd+uBCVpTPoDzD60kIViA0Xp97XbJIhUn4SDu43Ex1WNV/xXB8
         /Xxqk0FFsVF4+Fn7smBuolOw8yNWB+5H/xXbdviAaOX7Q8tdr42Lpjds7vovrEnuKKo8
         LdnA==
X-Gm-Message-State: AOJu0YzN/qOY34SoXz18pbqsPbtIB+wrerSF3YUGNAFe5c93R6gnKAMv
        jsPt6WJn7ZqU4KqZkRASTmk0hxcDHYdefqgeLDSxvltB9nTDgECJ3BA=
X-Google-Smtp-Source: AGHT+IFcRi9xf1a6sFEVOCtJ72EqRmPYlmptPZ9zVodgRg0sL1Mvl1Aq2N5Aw475MUcbdGt9JzSTMNqD99R/KLPKqYs=
X-Received: by 2002:a2e:9c06:0:b0:2bb:bf81:70f8 with SMTP id
 s6-20020a2e9c06000000b002bbbf8170f8mr5807451lji.48.1694387425698; Sun, 10 Sep
 2023 16:10:25 -0700 (PDT)
MIME-Version: 1.0
References: <F903A825-F05F-4B77-A2B5-7356282FBA2C@apple.com>
 <ZPZKsJUPVeHCsLQB@arm.com> <EDE8FE3D-043D-4A14-ACF6-71FF786C0D32@apple.com> <ZPi1LvrcGcSKBLqR@arm.com>
In-Reply-To: <ZPi1LvrcGcSKBLqR@arm.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Sun, 10 Sep 2023 19:10:14 -0400
Message-ID: <CAEXW_YTxLRAKCpFdKOdegj0gZdBb0OH+BnJf9FGTGfPtwiPkiw@mail.gmail.com>
Subject: Re: kmemleak handling of kfree_rcu
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Christoph Paasch <cpaasch@apple.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        MPTCP Upstream <mptcp@lists.linux.dev>, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hi Christoph,

On Wed, Sep 6, 2023 at 1:21=E2=80=AFPM Catalin Marinas <catalin.marinas@arm=
.com> wrote:
>
> On Tue, Sep 05, 2023 at 02:22:13PM -0700, Christoph Paasch wrote:
[..]
> > If you have an updated patch, let me know. I can test it.
>
> I sent it in reply to Joel.

Just checking if you got a chance to try Catalin's patch?

thanks,

 - Joel
