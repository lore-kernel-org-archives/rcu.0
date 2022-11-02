Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F35BC4332F
	for <rcu@archiver.kernel.org>; Wed,  2 Nov 2022 19:51:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbiKBTvy (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 2 Nov 2022 15:51:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbiKBTvx (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 2 Nov 2022 15:51:53 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7A7712D1A
        for <rcu@vger.kernel.org>; Wed,  2 Nov 2022 12:51:51 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id w4so26577qts.0
        for <rcu@vger.kernel.org>; Wed, 02 Nov 2022 12:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3DKcNQJ3RVEMM8vP+7GPSWzcDvUtzfV2i4+1GcoEVYE=;
        b=t/YKU2dmdzc3uJKYgMEHvq97DflAJLAihtzWhjZkX3UYffGjvnwWZItD5ig4U9YMEH
         wBiEn9AXWqOzPgT6Hb94xcep1Sh3E6zvqljAjUxQxZA8yRkxefLoVFszdJhUFqIKjsdD
         RHZed6UIzzjo4fcW6h518z1XrlkaPg7IcU0f4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3DKcNQJ3RVEMM8vP+7GPSWzcDvUtzfV2i4+1GcoEVYE=;
        b=m7C7Gjfs3YsqZVca6dYS212tzsX6OfULbo2lXzITez2j9SEOcsrpokU2KsPsJ8zHUy
         1TnmtnaFPfqN09aeID9/Nt9a5+pXoif+pNRLhMWkpRzHnXwlyRB/8YQSu1fLANf472v1
         6atGlRhn2wZHEAZ/QtdrP8zeOMVjarvhQ1Wc6gnj0jF5Ffkjb5spvOJ4gBsLfybrbexF
         s0H/QTmmpavwHjqZ7t8ahleQOflgvuroBiuoXUuJeJ3HjyEhpM/fXNWOB2HsABIf6aKh
         yA2wj5rukdx0Cg11zkyrN8JVVA6K1NJ2kxPlrLHgRtMDq1sg7KtVvf5nsWujZpA5CZpN
         XNhg==
X-Gm-Message-State: ACrzQf2LozLAfZwgr88hxuDxfyU8G4g/DhxG28jeSpW2Ono8mJrEXRHf
        LvhLmACRTg1YEeRbTnRQJ2uzSMSlLSVWaQ==
X-Google-Smtp-Source: AMsMyM7upmT3EwxwMAmeY2BOX7RVYtPqaPk4aHLcnlD09U86cii2ogN6TWpJxWcZuXadk4MC9OhUMQ==
X-Received: by 2002:ac8:5a42:0:b0:39d:136e:8a43 with SMTP id o2-20020ac85a42000000b0039d136e8a43mr20991571qta.372.1667418710987;
        Wed, 02 Nov 2022 12:51:50 -0700 (PDT)
Received: from smtpclient.apple (c-73-148-104-166.hsd1.va.comcast.net. [73.148.104.166])
        by smtp.gmail.com with ESMTPSA id bj41-20020a05620a192900b006f7ee901674sm9159593qkb.2.2022.11.02.12.51.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Nov 2022 12:51:50 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Joel Fernandes <joel@joelfernandes.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH RFC] rcu/kfree: Do not request RCU when not needed
Date:   Wed, 2 Nov 2022 15:51:49 -0400
Message-Id: <ED8E1017-A219-4815-BA28-5F44A2FB8FF2@joelfernandes.org>
References: <20221102183237.GO5600@paulmck-ThinkPad-P17-Gen-1>
Cc:     Uladzislau Rezki <urezki@gmail.com>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221102183237.GO5600@paulmck-ThinkPad-P17-Gen-1>
To:     paulmck@kernel.org
X-Mailer: iPhone Mail (19G82)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org



> On Nov 2, 2022, at 2:32 PM, Paul E. McKenney <paulmck@kernel.org> wrote:
>=20
> =EF=BB=BFOn Wed, Nov 02, 2022 at 06:30:24PM +0100, Uladzislau Rezki wrote:=

>>>=20
>>> to wait for a GP. Or if the poll_state_synchronize_rcu(oldstate)) !=3D 0=

>>> queue_rcu_work().
>>>=20
>> A small fix. If poll_state_synchronize_rcu(oldstate)) =3D=3D 0 then
>> queue_rcu_work() since a GP is still in progress.
>=20
> Both get_state_synchronize_rcu() and poll_state_synchronize_rcu()
> may be invoked from interrupt handlers.  And from NMI handlers,
> for that matter.

Thanks for clarifying. I meant to say cond_synchronize_rcu() cannot be calle=
d from interrupt context, but I made that comment before Vlad cooked his pat=
ch.

Thanks,

 - Joel


>                            Thanx, Paul
