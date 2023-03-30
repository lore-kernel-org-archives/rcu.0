Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13702C6FD1D
	for <rcu@archiver.kernel.org>; Thu, 30 Mar 2023 15:44:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233184AbjC3Poc (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 30 Mar 2023 11:44:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233139AbjC3Pob (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 30 Mar 2023 11:44:31 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F4FB755
        for <rcu@vger.kernel.org>; Thu, 30 Mar 2023 08:43:41 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id f188so5564799ybb.3
        for <rcu@vger.kernel.org>; Thu, 30 Mar 2023 08:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1680190997;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QNdOVmENz7bipgw5VyZ+YZ5XCiJvUtzq/ZrxnWco7YM=;
        b=KdKlFVxTiZTyXZpD730YSEXd+lS1WZysy4qqQuCKSILzTnn52PTIFgWkZpTVUEToR4
         9Vf5T56ewJnAXhoq40W8gsIvwFdED0mDSP/48XMjIOHeZRpq7s3zTa3FfEfYLrqIIkAx
         6sUHe+ASwxauLmsAFisYVlGmYYFZtQZSwEobQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680190997;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QNdOVmENz7bipgw5VyZ+YZ5XCiJvUtzq/ZrxnWco7YM=;
        b=6gMfQ72aejLYzVVgvAebXAkg0c9JzKZRAbxp6KnTV3ifozShv5R1ULoGKCa8guY31W
         7AC+oklk2wpb/p3kWsdy2TmhL5WIJAHqcNq8R8D/dg6PN2sJzAiwKqjOPVEEix8eLVPL
         vbhot4XlVudVNmKyusdGQqpgtqPsMHYeKKGMf76MPA1rG1rLD1vmzlfK0oh5c/iNM34y
         VCY/C/LABCf/9p858KwbQvoDynY6nKxlQhbw08BaU32Jb5ZYu1AblLEfHXxmRtLu3oVv
         1NV2iVMrWhP5/0Gibg37ryfp4jtPRmyW0/L+UhD/k+Vh2Wkw1BDVri+k9iB08ffb91AV
         MFxw==
X-Gm-Message-State: AAQBX9faxtSVAXc51roDA1jDlGp6VvjqmZuLmPaa4oPd2owelsiyDDoJ
        RpHRuTof/ICJFFiXVKvHZah60veB4onsIx0n5Hc1eA==
X-Google-Smtp-Source: AKy350ZLTxTX0qfaWZXrF4lRpRIQwKBcMIQYZiiwtN98o0sw/MG/QtlQ6BDRDDTJxDnZj/P/Lun14WJfExbt8cqtek8=
X-Received: by 2002:a05:6902:1886:b0:b6a:3632:12fd with SMTP id
 cj6-20020a056902188600b00b6a363212fdmr15955716ybb.2.1680190996978; Thu, 30
 Mar 2023 08:43:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230315181902.4177819-1-joel@joelfernandes.org>
 <20230315181902.4177819-5-joel@joelfernandes.org> <CAEXW_YR7njsiRxZtGpUftBQ0hFOzfzsLGQwfrgPwanucO8wATw@mail.gmail.com>
 <20230327101411.5298b38c@kernel.org>
In-Reply-To: <20230327101411.5298b38c@kernel.org>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Thu, 30 Mar 2023 11:43:06 -0400
Message-ID: <CAEXW_YTLOz9+PShzAwf=+B36cXwQkM3E2J=5M6YW_-_QuHWxxQ@mail.gmail.com>
Subject: Re: [PATCH v2 05/14] net/sysctl: Rename kvfree_rcu() to kvfree_rcu_mightsleep()
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        rcu <rcu@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Mar 27, 2023 at 1:14=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Sun, 26 Mar 2023 08:28:45 -0400 Joel Fernandes wrote:
> > > Cc: Eric Dumazet <edumazet@google.com>
> > > Cc: David S. Miller <davem@davemloft.net>
> >
> > Could anyone from the networking side Ack this patch so we can take it =
for 6.4?
> >
> > Eric or David?
>
> Let me help you. Perhaps it's a data point against keeping maintainers
> in an alphabetical order :-)
>
> Acked-by: Jakub Kicinski <kuba@kernel.org>

I applied this Ack to the patch, thank you!

 - Joel
