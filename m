Return-Path: <SRS0=sv12=BS=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_05,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94ADAC433E0
	for <rcu@archiver.kernel.org>; Sat,  8 Aug 2020 21:19:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E6B5206C3
	for <rcu@archiver.kernel.org>; Sat,  8 Aug 2020 21:19:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dPSE6jVA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726212AbgHHVT6 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sat, 8 Aug 2020 17:19:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbgHHVT5 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sat, 8 Aug 2020 17:19:57 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21EAFC061756
        for <rcu@vger.kernel.org>; Sat,  8 Aug 2020 14:19:57 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id i10so5754004ljn.2
        for <rcu@vger.kernel.org>; Sat, 08 Aug 2020 14:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=Efx0eQPWFDiEtI3TMpmnl3HA23YdCerjflULEQ2RJss=;
        b=dPSE6jVA7mjuPzTNxz7AINP5VT9h+DzrV0Ec0uhoUIFyxSxyfHyAp47nfvYzzrM7A5
         Y138f2WNlqWJmFImLQeDjvqPWOD25DpNemzzh0AtNYZCjtdtN8d/NFcczWPNkB1EDKt5
         OnM99x2SaunnCXRk13Gtthe1ySAH6eAh3qiouksUx2RLxzhQlSLpBHekLUcV/ipvv0Y8
         AlITUHXXf+FlK775AjSThvuq8UMLmyz8Ac24Im5TmYT9wMsPDyPiRN2SujuT62tO/4Br
         9KGiDMxScnFMuoV/t3ntN4cmo9J/9b6To+2P5CjplNR/n8AHP6mxCEZklXKR3+oLHu3x
         IFFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=Efx0eQPWFDiEtI3TMpmnl3HA23YdCerjflULEQ2RJss=;
        b=PbGk1zbo4RqzGBHasaHsVvX7LR6NrKm5XnVI3+1kv2CrKGWy+2kkPyWQx9ebJqnrZX
         af4Uw702eNJb59L0EQSbbFbcbLD2DGrQKEAAbPhXnQfcUFgu0soVFCWWxUAEqV3IhkRd
         KbMALuS5TgIQiiJ3aGlBk0FO6VFFuxshCTfYZImW2y+CT5XVuLsuuakTmWuu+MdxveZ2
         Ywe1+f0MfJrTnxAiZK2lMX236PdQq4oJRN2cJLRXUBJ+G94M7pN7b6WEQDjnLHFd90CE
         8Iwmx7h46yKbS9HOQmop8sqSlUO6boGRaQyV191Ho/rJPSflp0N05qLng+Lk33Orvs29
         V6Tg==
X-Gm-Message-State: AOAM532zsOpV/Kp3B1Kj7jy5Mpq1xw/HSbwtl1hJTOyDOJYYQcdf4m7L
        XQsZuPHWjc5Fe0A6LQK9AXtVH/uxn5R1f7PCxQJQRUOg
X-Google-Smtp-Source: ABdhPJz21rq8Ak4JsVQJb5F74WIDOqcskKjz11cW15qaQtUrPiZDql02VsNKHjEXg/W6jyt4FxAgQlM0yTvqyS2fhOY=
X-Received: by 2002:a2e:8904:: with SMTP id d4mr8593999lji.400.1596921594787;
 Sat, 08 Aug 2020 14:19:54 -0700 (PDT)
MIME-Version: 1.0
References: <CAF8i9mNFFrSqfoREnQoR-vrt+b_auq=xd9-yEP0eK-q1J-PvwA@mail.gmail.com>
 <CAF8i9mO3AcW+dnXvGsiJ7STu42OQEuqkTG0PGaCpZT=9OQq=Ug@mail.gmail.com>
In-Reply-To: <CAF8i9mO3AcW+dnXvGsiJ7STu42OQEuqkTG0PGaCpZT=9OQq=Ug@mail.gmail.com>
From:   William Tambe <tambewilliam@gmail.com>
Date:   Sat, 8 Aug 2020 16:19:42 -0500
Message-ID: <CAF8i9mMJCdadZkVDxCENhQbEVD4wmA1hU50nBo6AOhU16Y6cMg@mail.gmail.com>
Subject: Re: delayed_put_task_struct() used through call_rcu() by
 put_task_struct_rcu_user() never gets called
To:     rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sat, Aug 8, 2020 at 4:17 PM William Tambe <tambewilliam@gmail.com> wrote:
>
> On Sat, Aug 8, 2020 at 1:21 PM William Tambe <tambewilliam@gmail.com> wrote:
> >
> > I am having an issue in my kernel where delayed_put_task_struct() used
> > through call_rcu() by put_task_struct_rcu_user() never gets called.
>
> I am able to trace this issue to invoke_rcu_core() not getting called
> in __call_rcu_core() due to rcu_is_watching() always returning true.
>
> Any idea why I am seeing such an issue ?

Also, the issue is not happening when using highres=off .

>
> >
> > Any idea ?
