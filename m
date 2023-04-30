Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A13E0C77B60
	for <rcu@archiver.kernel.org>; Sun, 30 Apr 2023 19:56:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbjD3T4W (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 30 Apr 2023 15:56:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbjD3T4V (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 30 Apr 2023 15:56:21 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20097E4A
        for <rcu@vger.kernel.org>; Sun, 30 Apr 2023 12:56:20 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-55a2691637bso8458807b3.0
        for <rcu@vger.kernel.org>; Sun, 30 Apr 2023 12:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1682884579; x=1685476579;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=K6dNAdxANgOPif6J5hkVJuzTmZZPLKkVVW8NUx0g9ok=;
        b=cI+llQuEgTOvhFGvXSwz07oFG7RQdxcX/bYxk8fGCZyTLSoBqzKDpP7oXY6hyjNo6C
         ND1S1tJQR50ecOksWLuBQJdMhz1Pg7r/ohvOOKKAxHZaE5mv7wXSK1cXwsWKI2OayBxu
         vvQpwkyoO7nYK7mgkoySlyQLKK1DpfDFW0few=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682884579; x=1685476579;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K6dNAdxANgOPif6J5hkVJuzTmZZPLKkVVW8NUx0g9ok=;
        b=SunFVdLGGb4ey/pdut4O+beJnosuqL2VScp8Db2Z8Angat6m7d9Sfq0LVSkOtVFFVE
         RGqEatu/mvJhVhNQh+Y+aLPSsVvfHrrqQ9Ly16dyMjNIAK36ezanoNjGgjeJPJiEGKCe
         twUz9QkVhwo3f4h1A6LITlLMJAzNWDxUYnz8RMJEDMhtAE27+a0STGe1oa94mO8P88td
         xWy49ZmL2Xg1qmaFHB3KSzvbNdpq8MQnWxd8zUw3jqOPHqZ7b7v3T2cFTR81yRJmGNbn
         y4UZkyqZsdrdGPdNjWoCBLAmCOrjigg6RR+GibQCu5mlhFKmcVDcgJWEdPDy1VeIAGqP
         K1tQ==
X-Gm-Message-State: AC+VfDz/7tfp66DONlXrqlCAjNKj4Oe4YH6LnSEOCr5fVfad/dSQD0GS
        1Rimku+S4p4+JVXe8wkDTYWv/IjCOxLHdNg7YqixBmtZ+1Tl51SBeeU=
X-Google-Smtp-Source: ACHHUZ7RF8zaIIhTDctgyCBvw22eHQokkTo/kZlba1IuwPJ4YXmeE9nu960gKx3kWB/Lh/dPbDos7Jper8M13xsK1U4=
X-Received: by 2002:a81:75d4:0:b0:55a:10e9:2ce6 with SMTP id
 q203-20020a8175d4000000b0055a10e92ce6mr3407741ywc.50.1682884578858; Sun, 30
 Apr 2023 12:56:18 -0700 (PDT)
MIME-Version: 1.0
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Sun, 30 Apr 2023 15:56:11 -0400
Message-ID: <CAEXW_YSFm0XNMkfodBXVx-AsgJvcvGF+kmE+ZqU0Y=ehFJx+JQ@mail.gmail.com>
Subject: Exp GPs and rcu_read_unlock()
To:     rcu <rcu@vger.kernel.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hello,
Quick question (for educational purpose) for anyone - why does
PREEMPT=n kernel not want to get help from __rcu_read_unlock() for
expedited grace periods?

Basically, with PREEMPT=y kernels,  rcu_read_unlock_special.b.exp_hint
is set to true, but for PREEMPT=n, no such thing is done. Furthermore,
the __rcu_read_unlock() for PREEMPT=n does not help expedited GPs come
to an end either.

I am guessing the answer is, "no one cares about that", or "no one
reported needing this", but if there is another reason why a PREEMPT=n
kernel should not need it, do let me know :)

To make it more interesting, it appears that CONFIG_PREEMPT=y where
preemption is dynamically disabled, it _should_ have the  effect of
helping expedited GPs as far as I can see. Which further seems a
difference between booting PREEMPT=n versus PREEMPT=y + booting with
preemption turned off via boot option.

thanks,

 - Joel
