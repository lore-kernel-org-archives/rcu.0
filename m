Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59F62C4321E
	for <rcu@archiver.kernel.org>; Wed, 30 Nov 2022 19:21:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbiK3TVJ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 30 Nov 2022 14:21:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbiK3TUz (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 30 Nov 2022 14:20:55 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BCA583275
        for <rcu@vger.kernel.org>; Wed, 30 Nov 2022 11:20:54 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id cg5so11839351qtb.12
        for <rcu@vger.kernel.org>; Wed, 30 Nov 2022 11:20:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QTqXUSUHOfSCHe+q8lEezcpVoHrYxPM2K46ADRFSg4Q=;
        b=rJe4KttveESN6bqLtat/sAagy0F4KKW/91TY5Ydc/Kx5uqZeIHwD6IGOYlJFqBqq/6
         LunTJYbb1hSAdwE1sAbhVcMu6fcw5v0xsuu2iaxasGbHxYAfhKBPKsejSeiyBE4UQMit
         AuOMboAwJEyJpltGCRqBLw8or294DF8LJ850s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QTqXUSUHOfSCHe+q8lEezcpVoHrYxPM2K46ADRFSg4Q=;
        b=rsdEvZCXXzOliWFxf2qAdYZAR3wr+OEYEmJW1mh/7lx6fPENouVXmB/JI56XMsT37X
         jO2D5UU6bMuveGPGInJE4oKjTtrQnrxHLQIP3+eidJ4tVgyTs148+AjvqgW4zsZ13GU0
         XUMoxG6X38r23oXnGMkj9FQfAiq2wI/5rJKVMyxhI7ARrBlQKlcdTWkSCibPLfZQrScd
         D+Y9C5BJvUaWEe275bUWjnbkbazhgf8YacCqttNQ63hGCBbrERU3cu9VHa7RujGqeAo9
         yejHqeafusnmYdxkWB8bQRriPamBfzC095mHWLR3rGDe+U1yrUNkh6EM/luhoaUgkDvZ
         3Khg==
X-Gm-Message-State: ANoB5pkZWkaGzsPoKDyj28rdsDtNY5qmKCp8KQ7l2FerwP6vZAN4MEvR
        644yt6FltAVrpv9uDt49C27NGQ==
X-Google-Smtp-Source: AA0mqf58g0O4rzxbrzoBvEk2vIch+NoFrco8tr2vUXCSmOlH0ZhRx1JSuW2Ezbdm9OJJupUeGrvUyA==
X-Received: by 2002:ac8:5ec8:0:b0:3a5:280d:31ff with SMTP id s8-20020ac85ec8000000b003a5280d31ffmr39265777qtx.646.1669836053521;
        Wed, 30 Nov 2022 11:20:53 -0800 (PST)
Received: from smtpclient.apple (c-73-148-104-166.hsd1.va.comcast.net. [73.148.104.166])
        by smtp.gmail.com with ESMTPSA id z18-20020ac87112000000b0039853b7b771sm1299541qto.80.2022.11.30.11.20.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Nov 2022 11:20:52 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Joel Fernandes <joel@joelfernandes.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH rcu 14/16] rxrpc: Use call_rcu_hurry() instead of call_rcu()
Date:   Wed, 30 Nov 2022 14:20:52 -0500
Message-Id: <B4935931-239F-4C48-9646-2C20578F027C@joelfernandes.org>
References: <639433.1669835344@warthog.procyon.org.uk>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, Marc Dionne <marc.dionne@auristor.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-afs@lists.infradead.org,
        netdev@vger.kernel.org
In-Reply-To: <639433.1669835344@warthog.procyon.org.uk>
To:     David Howells <dhowells@redhat.com>
X-Mailer: iPhone Mail (19G82)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org



> On Nov 30, 2022, at 2:09 PM, David Howells <dhowells@redhat.com> wrote:
>=20
> =EF=BB=BFNote that this conflicts with my patch:

Oh.  I don=E2=80=99t see any review or Ack tags on it. Is it still under rev=
iew?

Thanks,

- Joel



>=20
>    rxrpc: Don't hold a ref for connection workqueue
>    https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/c=
ommit/?h=3Drxrpc-next&id=3D450b00011290660127c2d76f5c5ed264126eb229
>=20
> which should render it unnecessary.  It's a little ahead of yours in the
> net-next queue, if that means anything.
>=20
> David
>=20
