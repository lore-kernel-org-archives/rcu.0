Return-Path: <SRS0=q/VE=T7=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DCDAC04AB6
	for <rcu@archiver.kernel.org>; Fri, 31 May 2019 13:10:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1073726933
	for <rcu@archiver.kernel.org>; Fri, 31 May 2019 13:10:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="vpuma0pD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbfEaNK3 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 31 May 2019 09:10:29 -0400
Received: from mail-lj1-f176.google.com ([209.85.208.176]:38321 "EHLO
        mail-lj1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbfEaNK3 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 31 May 2019 09:10:29 -0400
Received: by mail-lj1-f176.google.com with SMTP id o13so9561830lji.5
        for <rcu@vger.kernel.org>; Fri, 31 May 2019 06:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=ApqGFkbLaaHBbOofZE6WmNmTCrldrxQ8NLN5BRDW+jY=;
        b=vpuma0pDETRc11/IM1kRALMe+OGEyz1tOXSuEBBZ7lk+YTR71oiEOWycYQfphiubxa
         eWHssRVAHxdHbCfOsZFA2JjrNfBWjyL0ZrGcIlO6jemBKckoXMG/tbcApSI2tAvTUDIy
         4sIv3xh5cpaehh7kFNunmkTZVCY9c7m6eNY8c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=ApqGFkbLaaHBbOofZE6WmNmTCrldrxQ8NLN5BRDW+jY=;
        b=Wb6XOyoCHY5Nf6+9FOQ18hPgAuuq4TNG6DyFb4+cRNUJPZIs6v0c7u8bgFeMHz154L
         XG4n30X2yU1bLfoEDjZYeqX1gi10VoIfUCwlh9l1yyJa2wiLckBsbtWtIfug23JcCBW0
         1qZ30eymxw9t1TRqerOMHImg6aYCTSI1eddHVwZ/jBe400x7K9BXBgj5TO9mB3ZnBC05
         rGVAc9cKdrMBTar6PIHec3UapcvkI4s3hlC43JfgIY4H16viLZaLzimEoW1H9Ihg+ICe
         nEJTd+KC4dyc1mbKGBjpvNUByi+E54QvPjxl436uCo0dwQkT5bOA24W/4LjD3J6C4xo0
         U2fw==
X-Gm-Message-State: APjAAAVKBtFzPycPJU7UUarff56ENMrB0eTXVc9X73pZxNPAWJUKOqDe
        +kibDbEiJqN8yRSoRr2P9EqaJh074eVlABPDLAFQ9w==
X-Google-Smtp-Source: APXvYqyqkUiMz1u0H1vNRehO00nUgnzduwCazeIL10PXbXsON1A26T2XIqeuBj12W2aA8VxrNHbRVOcGcYpV3GR6oYY=
X-Received: by 2002:a2e:6109:: with SMTP id v9mr5941816ljb.205.1559308227495;
 Fri, 31 May 2019 06:10:27 -0700 (PDT)
MIME-Version: 1.0
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Fri, 31 May 2019 09:10:16 -0400
Message-ID: <CAEXW_YTzUsT8xCD=vkSR=mT+L7ot7tCESTWYVqNt_3SQeVDUEA@mail.gmail.com>
Subject: Question about cacheline bounching with percpu-rwsem and rcu-sync
To:     Oleg Nesterov <oleg@redhat.com>,
        Eric Dumazet <edumazet@google.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     rcu <rcu@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hi,
As per the documentation for rationale of percpu-rwsem, the Documentation says:

The problem with traditional read-write semaphores is that when multiple
cores take the lock for reading, the cache line containing the semaphore
is bouncing between L1 caches of the cores, causing performance
degradation.

However, it appears to me that the struct percpu_rwsem "rss" element
which is used by the RCU-sync is not a per-cpu element. So even in the
fastpath case (only readers and no writers), the cacheline containing
rss is shared and will bounce by multiple CPUs. For that matter, even
the cacheline containing the percpu_rw_semaphore itself will be bounce
among multiple reader CPUs.

So how does percpu-rwsem eliminate cache line bouncing in the common
case. Could you let me know what I am missing?

Thanks a lot.
