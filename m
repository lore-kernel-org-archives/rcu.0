Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F9BDC6FD19
	for <rcu@archiver.kernel.org>; Thu, 16 Mar 2023 13:28:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbjCPN2u (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 16 Mar 2023 09:28:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230330AbjCPN2q (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 16 Mar 2023 09:28:46 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 036966F482
        for <rcu@vger.kernel.org>; Thu, 16 Mar 2023 06:28:43 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id l13so1639810qtv.3
        for <rcu@vger.kernel.org>; Thu, 16 Mar 2023 06:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1678973323;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mq05T+mqYchdO6eVgaCmPyYAruAZx/QKv/nYoCC7GvE=;
        b=gtIvtqKZjbnizmS8t3q0lgTHjhzQuSiektGAU7yoNCrCEGjyt74+35bI9cf/AouYOg
         i9q2/s2WPzwpd10R0HLiYLs9GXw2M8MNKrIspd2LMnciGoj/JjZAgoWmSVO2GCZIwR4N
         whaHxtw3NlKu4M3za5UQkxHLEkj1CzxdB+Yrc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678973323;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mq05T+mqYchdO6eVgaCmPyYAruAZx/QKv/nYoCC7GvE=;
        b=gwNth/fgc5vX0/1uwk+tBHyJAylU7ehZijonQ8J2O6P+5ojN++nXwZ/lgZUmmUx47e
         ncBLNQ71/eu9dtnSBcxKsU0bv6OCkJK0wECRKrVEoMjHVedjHtljIiA1ENxvPdmFZLW8
         YKilj++aDNG0INesfN3D9jbNkUYz6yJczuUeyOLeHSGvsNqghn/VLRTL/BNp7a+0Vx2F
         4LEYyH8KSZ2iYPS022CyCmDYeaL0pDnDU596d4A0po6hdgrkfOR9WqVjH8BV/KZFdoQL
         7qfZJAsleRnjtLcxpk/AOAxt4ftHyOOTNof/jC79bV210duKQh8HvuaWQ/mOZsN/lweH
         kAqw==
X-Gm-Message-State: AO0yUKXq2qO9x5huF6M9ysJkXZxtcIhMU+aoPAdE0A9eyN/nhH1ET4O3
        nfvROgxeAxy3hYHmL8ElmZtQ1Q==
X-Google-Smtp-Source: AK7set8shGyWYizyY6RNgWTdQAw4vWEX0VNS0sxE9of5pEe8x9LdR1zyuafDT2JKIuNlsh1wANUj6g==
X-Received: by 2002:a05:622a:14cb:b0:3d5:1fc6:587b with SMTP id u11-20020a05622a14cb00b003d51fc6587bmr6471346qtx.18.1678973322822;
        Thu, 16 Mar 2023 06:28:42 -0700 (PDT)
Received: from smtpclient.apple ([2600:1003:b840:cfc9:d51f:7877:7172:21f6])
        by smtp.gmail.com with ESMTPSA id de21-20020a05620a371500b007422fd3009esm5994590qkb.20.2023.03.16.06.28.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Mar 2023 06:28:42 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Joel Fernandes <joel@joelfernandes.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 1/1] rcu/rcuscale: Stop kfree_scale_thread thread(s) after unloading rcuscale
Date:   Thu, 16 Mar 2023 09:28:31 -0400
Message-Id: <2B9F2C1A-B274-41EF-8ABE-1E660521BCE4@joelfernandes.org>
References: <IA1PR11MB61714FEEAF2C46639891401A89BC9@IA1PR11MB6171.namprd11.prod.outlook.com>
Cc:     paulmck@kernel.org, Frederic Weisbecker <frederic@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <IA1PR11MB61714FEEAF2C46639891401A89BC9@IA1PR11MB6171.namprd11.prod.outlook.com>
To:     "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
X-Mailer: iPhone Mail (20B101)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org


> On Mar 16, 2023, at 9:17 AM, Zhuo, Qiuxu <qiuxu.zhuo@intel.com> wrote:
>=20
> =EF=BB=BF
>>=20
>> From: Paul E. McKenney <paulmck@kernel.org>
>> [...]
>>>>=20
>>>> How about to pull the rcu_scale_cleanup() function after
>> kfree_scale_cleanup().
>>>> This groups kfree_* functions and groups rcu_scale_* functions.
>>>> Then the code would look cleaner.
>>>> So, do you think the changes below are better?
>>>=20
>>> IMHO, I don't think doing such a code move is better. Just add a new
>>> header file and declare the function there. But see what Paul says
>>> first.
>>=20
>> This situation is likely to be an early hint that the kvfree_rcu() testin=
g should
>> be split out from kernel/rcu/rcuscale.c.
>=20
> Another is that it's a bit expensive to create a new header file just for=20=

> eliminating a function declaration. ;-)

What is so expensive about new files? It is a natural organization structure=
.

> So, if no objections, I'd like to send out the v2 patch with the updates b=
elow:
>=20
>   - Move rcu_scale_cleanup() after kfree_scale_cleanup() to eliminate the
>     declaration of kfree_scale_cleanup(). Though this makes the patch bigg=
er,=20
>     get the file rcuscale.c much cleaner.
>=20
>   - Remove the unnecessary step "modprobe torture" from the commit message=
.
>=20
>   - Add the description for why move rcu_scale_cleanup() after
>     kfree_scale_cleanup() to the commit message.

Honestly if you are moving so many lines around, you may as well split it ou=
t into a new module.

The kfree stuff being clubbed in the same file has also been a major annoyan=
ce.

 - Joel=20


> Thanks!
> -Qiuxu
>=20
>> [...]
