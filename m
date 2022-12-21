Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5940DC4332F
	for <rcu@archiver.kernel.org>; Wed, 21 Dec 2022 02:41:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234186AbiLUClc (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 20 Dec 2022 21:41:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234040AbiLUClb (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 20 Dec 2022 21:41:31 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA4371C112
        for <rcu@vger.kernel.org>; Tue, 20 Dec 2022 18:41:30 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id a16so12718019qtw.10
        for <rcu@vger.kernel.org>; Tue, 20 Dec 2022 18:41:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fMhzqhqWq7UkrwtJ6ZqboyA3KFySyX0rXKAhLHPSdxI=;
        b=l3utyhobS6jS5RhkL2EKink3aSp7+2VybDeEXko1NcMcqStPk1+tFzxDNvKrGu8ffd
         LL8fxBQRBnsoL7MQz7KzDa+HJRuURIRzpjwN1XC9uFMIVcDg1emThrU2NYPk70waUUnH
         +QGtxyvyvOex0N1E7n/948MavKr8bQU3HUc60=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fMhzqhqWq7UkrwtJ6ZqboyA3KFySyX0rXKAhLHPSdxI=;
        b=CF8jMs4srE7uJfjKIq2Iv0V0da5CnHhffpQt1go3+yCQ/PeHwLBZ4mQIdDrMokIiV6
         rhlSBShHmXsmA6ce2S4it2Km2c97twTiID3JUsonVcOFvjNbfbXgWqWDfF41u/5STxub
         Vgs1nbO+8quefP9nOXinLM5aQhAffNc/986TT8R7jKR5mSVNeN4FcVUyrLxy1sppUBmT
         GR78gNQN+l3TDDpWlRPtvjDSkXGiLRTVfognYBLTj+nLgpehYoTGFJiY1Sa7ULaXCKzi
         9LkW8XPxpFAT4WyK0yA8k4rQCDLq5F7Y/4PV6Asi+zF4kLmDzVCSGXoqLJVCvVHAMOLC
         rx5A==
X-Gm-Message-State: AFqh2kpYmrFdcO2aactM5qu/c0GeMXfXbYtL0M40iHo8AQnau4x+kIKQ
        eQc13FQ1AA5nmGOX7weYmtw5HmCoZPLz4PczcY0=
X-Google-Smtp-Source: AMrXdXsXSk03wijWPMH7tmFpozZvDgbIcfRVQH3NWQ0YJTsvJWJT3pFsqo0N2zFyB6t4H9DjiagPYg==
X-Received: by 2002:ac8:735a:0:b0:3a6:2170:b089 with SMTP id q26-20020ac8735a000000b003a62170b089mr6859611qtp.12.1671590489812;
        Tue, 20 Dec 2022 18:41:29 -0800 (PST)
Received: from smtpclient.apple (c-98-249-43-138.hsd1.va.comcast.net. [98.249.43.138])
        by smtp.gmail.com with ESMTPSA id i17-20020a05620a405100b006fcb77f3bd6sm10471535qko.98.2022.12.20.18.41.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Dec 2022 18:41:28 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Joel Fernandes <joel@joelfernandes.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC 0/2] srcu: Remove pre-flip memory barrier
Date:   Tue, 20 Dec 2022 21:41:17 -0500
Message-Id: <0B1950D8-9319-4F25-B14B-4ED949A57BE0@joelfernandes.org>
References: <20221221004957.GA29021@lothringen>
Cc:     linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
In-Reply-To: <20221221004957.GA29021@lothringen>
To:     Frederic Weisbecker <frederic@kernel.org>
X-Mailer: iPhone Mail (20B101)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org



> On Dec 20, 2022, at 7:50 PM, Frederic Weisbecker <frederic@kernel.org> wro=
te:
>=20
> =EF=BB=BFOn Tue, Dec 20, 2022 at 07:15:00PM -0500, Joel Fernandes wrote:
>> On Tue, Dec 20, 2022 at 5:45 PM Frederic Weisbecker <frederic@kernel.org>=
 wrote:
>> Agreed about (1).
>>=20
>>> _ In (2), E pairs with the address-dependency between idx and lock_count=
.
>>=20
>> But that is not the only reason. If that was the only reason for (2),
>> then there is an smp_mb() just before the next-scan post-flip before
>> the lock counts are read.
>=20
> The post-flip barrier makes sure the new idx is visible on the next READER=
's
> turn, but it doesn't protect against the fact that "READ idx then WRITE lo=
ck[idx]"
> may appear unordered from the update side POV if there is no barrier betwe=
en the
> scan and the flip.
>=20
> If you remove the smp_mb() from the litmus test I sent, things explode.

Sure I see what you are saying and it=E2=80=99s a valid point as well. Howev=
er why do you need memory barrier D (labeled such in the kernel code) for th=
at? You already have a memory barrier A before the lock count is read. That w=
ill suffice for the ordering pairing with the addr dependency.
In other words, if updater sees readers lock counts, then reader would be ma=
king those lock count updates on post-flip inactive index, not the one being=
 scanned as you wanted, and you will accomplish that just with the mem barri=
er A.

So D fixes the above issue you are talking about (lock count update), howeve=
r that is already fixed by the memory barrier A. But you still need D for th=
e issue I mentioned (unlock counts vs flip).

That=E2=80=99s just my opinion and let=E2=80=99s discuss more because I cann=
ot rule out that I am missing something with this complicated topic ;-)

Thanks.=
