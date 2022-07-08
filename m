Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 940A4C43334
	for <rcu@archiver.kernel.org>; Fri,  8 Jul 2022 17:19:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238487AbiGHRTg (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 8 Jul 2022 13:19:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238453AbiGHRTf (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 8 Jul 2022 13:19:35 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CCD8165A3
        for <rcu@vger.kernel.org>; Fri,  8 Jul 2022 10:19:34 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id g6so2492666qtu.2
        for <rcu@vger.kernel.org>; Fri, 08 Jul 2022 10:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=jnDLgQ9Q46n+6q9Il7kmijSeKjTCNPPGgpx878kr/Nk=;
        b=xaSbSVnr6wyezd6EmmGuXlXz4CU3+O0m/JC2jZzC+3KFeo948b/zaUW6HUuGsGfqsR
         vdorjOibuT4jx7hFCVCXxRKVq/ZKvxaCeKqIcXr0SA9WPPx1ARcFLyCO97LUcp4rxKjH
         5NsxhXRpYRRe2sPMtD9BPy5acRijJRnB7CKpU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=jnDLgQ9Q46n+6q9Il7kmijSeKjTCNPPGgpx878kr/Nk=;
        b=1jxFii7KY0UJ/fvTkyNX7ticqC+PCVHnVz4T5sp+S7o4oXWBqqavnD5Yw6Cayofimu
         3x397PsJxKh6CSUZ3Mvnv/I5rg4a3MyWTsdibb71orFjrh26mmHYUGHlGmO6PaoXq4ZR
         iANDS8qfHSopsLMjQyn+RT043dwfnWhy+SY4npPPumGaDHL60wBex6Y9PHpI7lRGFDrL
         vjqrGaTEGe7YKc4gWEg+Lg/1EVXMCnVUrFtU6wyxQ8ci38k73T5R+5tMJjOX5MM4sGMM
         sYgtUfb/t5KRsO3LtF4iTezJwmWgnjQlWOkfs6w4lsek0V0FIXfSkG8lRCguE/COXFNc
         wzxQ==
X-Gm-Message-State: AJIora8KP3LRjrpPRvbHpytLGB0qUmm1TTpJUyI6HXDpQBMgexWzDv4E
        APsHke+XeMIuRQUsqJxTPlvGh7hOR5+sVw==
X-Google-Smtp-Source: AGRyM1s3rt2S38b01HXiloEMwdvfS43Xu0UASZ5D/bozuOyw+A5OPJTV9x4lGHBqdUn47eReSE2Fkw==
X-Received: by 2002:ac8:5e4d:0:b0:31d:9bf8:1963 with SMTP id i13-20020ac85e4d000000b0031d9bf81963mr3979691qtx.530.1657300773331;
        Fri, 08 Jul 2022 10:19:33 -0700 (PDT)
Received: from localhost (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id v123-20020a379381000000b006a6c230f5e0sm26934680qkd.31.2022.07.08.10.19.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 10:19:33 -0700 (PDT)
Date:   Fri, 8 Jul 2022 17:19:32 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     rcu@vger.kernel.org, paulmck@kernel.org, frederic@kernel.org
Cc:     len.brown@intel.com
Subject: About dynamic switch to offload/nocb on non-server Intel machines
Message-ID: <YshnJLAmLtw90y2E@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Dear Paul and Frederic,

Len Brown on CC provided a good idea in a meeting on using intel_pstate to
detect if device is a server or a consumer device.

Can we perhaps use this to trigger the offload/nocb mechanisms on consumer
devices / distros? I was thinking the dynamic offload and the "one kernel"
work that Frederic did can be trigger from such detection.

It is true userspace can do the trigger, but maybe it is better to not leave
it to userspace so we'd save power on bad userspaces.

Come to think of it, this can even be done at boot time if we can read the
below state early enough:

> intel_pstate.c demonstrates how to detect a server when ACPI is present:
>
>
>
> #ifdef CONFIG_ACPI
>
>
>
> static bool intel_pstate_acpi_pm_profile_server(void)
>
> {
>
>         if (acpi_gbl_FADT.preferred_profile =3D=3D PM_ENTERPRISE_SERVER |=
|
>
>             acpi_gbl_FADT.preferred_profile =3D=3D PM_PERFORMANCE_SERVER)
>
>                 return true;
>
>
>
>         return false;
>
> }
>
