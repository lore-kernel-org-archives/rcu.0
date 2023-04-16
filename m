Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33B9CC77B61
	for <rcu@archiver.kernel.org>; Sun, 16 Apr 2023 08:52:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbjDPIw3 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 16 Apr 2023 04:52:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjDPIw2 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 16 Apr 2023 04:52:28 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE476106
        for <rcu@vger.kernel.org>; Sun, 16 Apr 2023 01:52:26 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id hg12so8167501pjb.2
        for <rcu@vger.kernel.org>; Sun, 16 Apr 2023 01:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681635146; x=1684227146;
        h=to:date:message-id:subject:mime-version:content-transfer-encoding
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=u96SJZnSylq4Q/CnyzwEcOlzz3javieOamaWoBlsvzQ=;
        b=oumrIvnAUsXNPidic3WnZ9UNl/q0vT2kd+US245T7D7FN7Raxv0GEONfVWLWDM7nPS
         iwkCU4fgS0huYyPXmGxmboSBG6Ti+igIdWzy5bFmeXl0YHlDFjpmq1yaYN8Mez0CQWhk
         uO7CvfZ4eIp/iZbwDB0VRD3X4270RIl2Ug9SiFkLdBnnqjJBUl9NrAt8op1XD5HU+mgn
         54zsDCYUhFfm32qso23msEosRxWmzMUECc/joH5ADWGODBYuZMzkHQqJRdMzswseAodk
         dF2iauvgiz+nO4BmUOe59GxUwJZPvyIZ+BE0WgE9q2pTYevAexCOYWFYPtQOl3bznKNg
         /ngw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681635146; x=1684227146;
        h=to:date:message-id:subject:mime-version:content-transfer-encoding
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u96SJZnSylq4Q/CnyzwEcOlzz3javieOamaWoBlsvzQ=;
        b=iEdijRkFZHNxm7G1UbagmuZ+hNGgVaj04Q37VMzlpmfPzejGM1wdbz7Cc9R7aAxY1m
         c6HYUmwnfTMdB1ZXQeWH9EwA4i6LCQfGY9y/ges+V6Is99kthk6doUPSvjvyfmIDjSfZ
         CkX2cPBO42N8S30IiggThv3JCnX8XK3l6VSkC4hB+Yi24apqS0J7jCGFFn+45/MVjZ9m
         Y0q4Ec0JZG449CVqrlYKFWuIW/iUcqcy6FO5iIZPaFV7ywMMw9rVjLVj8VOe+SiSv8dj
         HrnbjD1qeYhJgjeJXMI69kiylBiuXaSE4tjwiZF3KNUMmnAqb8rIdkyIfkcsw2nqkER9
         L9YA==
X-Gm-Message-State: AAQBX9e6r6vxAIKbX6+TWkH7/OA25gdWYbk7EiYHoaCWHwCi9hHrwXPD
        AXuo2HK6IV9VgW61kUs88Jo8Aw/poeZFealG
X-Google-Smtp-Source: AKy350Ydzr+DHexScoW+X7aAbBZJ9ljxhBr4or8xYqVF9Un2N+ybR02Li6e2Kyi/7qGSE66cTOfSug==
X-Received: by 2002:a17:902:7489:b0:19f:3d59:e0ac with SMTP id h9-20020a170902748900b0019f3d59e0acmr8297891pll.44.1681635146004;
        Sun, 16 Apr 2023 01:52:26 -0700 (PDT)
Received: from [127.0.0.1] ([2402:d0c0:2:a2a::1])
        by smtp.gmail.com with ESMTPSA id c7-20020a170902848700b001a20b30e8b0sm5598502plo.243.2023.04.16.01.52.24
        for <rcu@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Apr 2023 01:52:25 -0700 (PDT)
From:   Alan Huang <mmpgouride@gmail.com>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.21\))
Subject: Question: Why the definition of ULONG_CMP_LE is different with
 time_before?
Message-Id: <59BEC41C-E025-47EE-AA47-9B9795234415@gmail.com>
Date:   Sun, 16 Apr 2023 16:49:24 +0800
To:     rcu@vger.kernel.org
X-Mailer: Apple Mail (2.3654.60.0.2.21)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hi,

I noticed that the definition of ULONG_CMP_LE in rcupdate.h is different =
with time_before.

I can=E2=80=99t figure it out that why their definition is different. =
Does the two definition are the same thing?

Thanks,
Alan



