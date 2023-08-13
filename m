Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69320C04A6A
	for <rcu@archiver.kernel.org>; Sun, 13 Aug 2023 14:41:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbjHMOlv (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 13 Aug 2023 10:41:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230333AbjHMOlu (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 13 Aug 2023 10:41:50 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC5AA10DE
        for <rcu@vger.kernel.org>; Sun, 13 Aug 2023 07:41:52 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2b9b904bb04so54639761fa.1
        for <rcu@vger.kernel.org>; Sun, 13 Aug 2023 07:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1691937711; x=1692542511;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jnO3PmCn30n5xbeq5GUi5oVZC3HsNOcy8ts4GlaH4vE=;
        b=CTC0lsczhmswXNxFIM3zvA/6X+f7vThA2LJ2rcZbyecUXg3iTed62Ipg+dmpBLb79B
         RgBe9gYx1wsPdFg2SUldO4WC5z38PQOCJufWrL3aua7aV6kkdaLpcQYjnGx3L7b0XYAB
         0KcejgbBkGAslci8El2DeARYPfUnW6KMd39lA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691937711; x=1692542511;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jnO3PmCn30n5xbeq5GUi5oVZC3HsNOcy8ts4GlaH4vE=;
        b=GNe7oz1nCK4t1VGKTWYiQGcryT77aH2JBIN8kweUMf43xfTh4d0Db6RO8k4m7UlB0j
         Ash4o/NJxGmVCJqmwL2rdshHpyHvkFuL/RkKxL9QhYFUSbg9dLLjjxkP+1+ob0GN/oZ4
         qPBAYa8fOqtNdfiIBWXLFH5efSDfqk7p8u6kTsHnsk6Dm6djSgmYelGHwosQ8FWyAHLx
         h0NLLGPhPgKJUZkz7vvr4FdeFD4xPQ3WzRGtRxjAkSsAYT2u+sFXCBPKm5ugCVEyd0+N
         YSGwizUHDLi9NvaIDHblliYqw5BbISdBRrTlpVsHOmb2WdnUX+YBB8lHDt4r201HUvAM
         eB7A==
X-Gm-Message-State: AOJu0YxVTY1DwiTdJ4Xa10unLu07h9N2NNkmSX7zPRxKKK4Wzo4ki7vU
        k7pAwsSP3TB/9sdo4Tbf3Zauyt0KChhKLe5P+YD+KA==
X-Google-Smtp-Source: AGHT+IHxbQigoKtMcn3roqdpsFfVukg6GeGMbqguN1Xof1u3+VwFxhgH6/lyOLcKxb5c8D8h678jAV5EAh0ntivHY08=
X-Received: by 2002:a05:651c:104a:b0:2b8:67ce:4ad7 with SMTP id
 x10-20020a05651c104a00b002b867ce4ad7mr4969134ljm.6.1691937710915; Sun, 13 Aug
 2023 07:41:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230813033737.3731290-1-joel@joelfernandes.org> <2023081317-engine-pauper-2a6a@gregkh>
In-Reply-To: <2023081317-engine-pauper-2a6a@gregkh>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Sun, 13 Aug 2023 10:41:41 -0400
Message-ID: <CAEXW_YRW4Q2mtaKjyHpLhfjuF04aLO6UBrvWvUrOYSU-kg=7SQ@mail.gmail.com>
Subject: Re: [PATCH] rcutorture: Copy out ftrace into its own console file
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Shuah Khan <shuah@kernel.org>, Joel <agnel.joel@gmail.com>,
        rcu@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sun, Aug 13, 2023 at 2:28=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Sun, Aug 13, 2023 at 03:37:36AM +0000, Joel Fernandes (Google) wrote:
> > From: Joel <agnel.joel@gmail.com>
> >
> > Often times it is difficult to jump to the ftrace buffers and treat it
> > independently during debugging. Copy the contents of the buffers into
> > its own file.
> >
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
>
> "From:" doesn't match the signed-off-by :(

Yeah I suck. Apparently I still don't know how to send a patch after 13 yea=
rs.
