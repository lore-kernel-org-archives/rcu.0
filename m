Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 617D3EC8758
	for <rcu@archiver.kernel.org>; Thu,  7 Sep 2023 20:03:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232440AbjIGUDw (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 7 Sep 2023 16:03:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbjIGUDw (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 7 Sep 2023 16:03:52 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54F2CE47
        for <rcu@vger.kernel.org>; Thu,  7 Sep 2023 13:03:46 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-41368601e92so8455421cf.3
        for <rcu@vger.kernel.org>; Thu, 07 Sep 2023 13:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1694117025; x=1694721825; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hTExBqFMFYjUPrU+xAhsJaEOqNLhaz3e9ocmRAD1wlU=;
        b=YCTMgXgLx551A01aCotgbLGmxKT929+QyxlgKiUqrNS6qnSbvoZHsS+Fngaz7wC07u
         RTl1BarYBir6UcBM9dKxu4hYIrQvQO/jUjWLKlfmVvwGLE/FR83Zn4NZk8oJ/LMbMgw5
         7geXYxEr2UUor5/qJQFcTrzdseuuLd396qoCk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694117025; x=1694721825;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hTExBqFMFYjUPrU+xAhsJaEOqNLhaz3e9ocmRAD1wlU=;
        b=Qxbb8H+Ke7V18JfpfVW2nt7YW6u78lVb7Due6gyKiYHQFBd8DzbkNWCz9oEDNn72xJ
         kDYvx5+LqMMK4DIzVJFw/vxMwus5lABxUylGQeewgmOzt496+O8kZoWcpcL9KUTahzF/
         /7sgtaigx0xjDSgMnoLrXf2i7Ukq5ySgaaQRlaOzNqsMqHRE8FT7n8p5sstOwGtDjGQr
         xARDDGtTZpXEFiwLWubp6pNgwoCvxz7EY9w1r31kQ0v7tUsurgnZzaJdLaME0i7aR0Yt
         CtkFquyM6VB90oW9ImLuMz+IfE5Cn77oEDGSOA0Kpp4CCxKhZLT8arFSdbH4ecSF3PuL
         pdMA==
X-Gm-Message-State: AOJu0YxpAWqwXVKjl9kV0iMOU/Bzs/6tbehkw15TgoB50v9Bo+0rL11j
        kCRTYAmb4rBwJetwERTcgBOgt4iNlvfnJJx08Cc=
X-Google-Smtp-Source: AGHT+IEPXEDUQByCrBR5yOUbU1zGKPzl50KJilzIhxMkuxze2rfBVzVXNaWu5Jyl/9cFLWDO23KaaA==
X-Received: by 2002:a0c:dd8d:0:b0:651:5f39:4564 with SMTP id v13-20020a0cdd8d000000b006515f394564mr273510qvk.51.1694117025036;
        Thu, 07 Sep 2023 13:03:45 -0700 (PDT)
Received: from smtpclient.apple ([192.145.116.83])
        by smtp.gmail.com with ESMTPSA id u26-20020a0cb69a000000b0064f46c719fasm62572qvd.31.2023.09.07.13.03.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Sep 2023 13:03:44 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Joel Fernandes <joel@joelfernandes.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [BUG] TREE04 hang on 6.5.y stable: Writer stall state RTWS_COND_SYNC_FULL
Date:   Thu, 7 Sep 2023 16:03:33 -0400
Message-Id: <FFC37117-94F4-49EC-86D7-508753C48A11@joelfernandes.org>
References: <208d035b-a411-40d0-bb5e-59deb6a785e6@paulmck-laptop>
Cc:     Joel Fernandes <joelaf@google.com>, rcu@vger.kernel.org
In-Reply-To: <208d035b-a411-40d0-bb5e-59deb6a785e6@paulmck-laptop>
To:     paulmck@kernel.org
X-Mailer: iPhone Mail (20B101)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org



> On Sep 7, 2023, at 12:23 PM, Paul E. McKenney <paulmck@kernel.org> wrote:
>=20
> =EF=BB=BFOn Thu, Sep 07, 2023 at 09:17:15AM -0400, Joel Fernandes wrote:
>> Hi,
>> Just started seeing this on 6.5 stable. It is new and first occurrence:
>>=20
>> TREE04 no success message, 234 successful version messages
>> [033mWARNING:  [mTREE04 GP HANG at 14 torture stat 2
>> [   38.371120] ??? Writer stall state RTWS_COND_SYNC_FULL(10) g1253
>> f0x0 ->state 0x2 cpu 6
>> [   38.388342] Call Trace:
>> [   53.741039] ??? Writer stall state RTWS_COND_SYNC_FULL(10) g3637
>> f0x2 ->state 0x2 cpu 6
>> [   69.093462] ??? Writer stall state RTWS_COND_SYNC_FULL(10) g5501
>> f0x0 ->state 0x2 cpu 6
>> [   84.450028] ??? Writer stall state RTWS_COND_SYNC_FULL(10) g10505
>> f0x0 ->state 0x2 cpu 6
>> [   99.815871] ??? Writer stall state RTWS_COND_SYNC_FULL(10) g13781
>> f0x0 ->state 0x2 cpu 6
>> [  115.166476] ??? Writer stall state RTWS_COND_SYNC_FULL(10) g16544
>> f0x0 ->state 0x2 cpu 6
>> [  130.550116] ??? Writer stall state RTWS_COND_SYNC_FULL(10) g18941
>> f0x0 ->state 0x2 cpu 6
>> [..]
>>=20
>> All logs:
>> http://box.joelfernandes.org:9080/job/rcutorture_stable/job/linux-6.5.y/1=
7/artifact/tools/testing/selftests/rcutorture/res/2023.09.07-04.10.25/TREE04=
/
>=20
> Huh.  Does this happen for you in v6.5 mainline?
>=20
> Both the code under test (full-state polled grace periods) and the
> rcutorture test code are fairly new, so there is some reason for general
> suspicion.  ;-)

Ah. I never saw it on either 6.5 mainline or stable till today. Even on stab=
le
I only ever saw it this once. On mainline I have not seen it yet but I do te=
st
stable much more since I have been on stable maintenance duty ;-).

I will keep an eye on it.. this also happens quite early per that time stamp=
. thanks,

- Joel=20




>=20
>                            Thanx, Paul
