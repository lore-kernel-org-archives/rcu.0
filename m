Return-Path: <SRS0=/vWc=V5=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A5B4C19759
	for <rcu@archiver.kernel.org>; Thu,  1 Aug 2019 18:14:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59E4820644
	for <rcu@archiver.kernel.org>; Thu,  1 Aug 2019 18:14:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="aOOZFewR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388108AbfHASOT (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 1 Aug 2019 14:14:19 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42740 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732044AbfHASOT (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 1 Aug 2019 14:14:19 -0400
Received: by mail-pf1-f194.google.com with SMTP id q10so34516473pff.9
        for <rcu@vger.kernel.org>; Thu, 01 Aug 2019 11:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eE8rv9dyKGAYAJtLla4BFHdrRwNRy2IAAs0/Jzr7l7U=;
        b=aOOZFewRBoZl8qWJS4sCOPwOKXvV0/PidRlBuT5X5LuV4T9afgtzKkDfxSMVTe95Du
         PWMZT0VwSm1nDNz/otVLmFg9vkggfeSsSxIYBECv1ajy3d7Uwwvh5BGIyDC0nIOx9BY/
         u4qXkuVWPrTorzyY+MvaWyas2BHnEF1VmBQUU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eE8rv9dyKGAYAJtLla4BFHdrRwNRy2IAAs0/Jzr7l7U=;
        b=Q/VGtlWb3XIt7OS8O0+rluT2BSm1x7px+rPoXhtWGXv11tNZ29KanP+VMFVWbu3nJn
         v24QyFDqPHj15A0pHRFND10Kyq84grIh3h5mcsHsAiOuSfc4wR5ODWa5WDzfJYwZkxW6
         vj4vvj5NDCevRNag/EFxn4xFXosEqvwHAtqvrL0OFSIRofySmCrGxrbfSWTkgcRawT0v
         iT+8sv+EvKbmvmtQH12QYgN1sm5v8c8cLi6UgHyJzIEOI8VD2YkYyqnLKM3G7hD5hlTX
         LdHOPtlXbMiedqUzoamNJM16qvNSGP62LF3b0wVIxCAKbZ3zOSHDG3AxhlyjcU8ALHu4
         dOEw==
X-Gm-Message-State: APjAAAWnAgUp0ttBM/pUlTdC10bEiQL4Y7sqhER9xama3+UO1lbXN59s
        M80IA4AvsKVRWkigTGZ0hSI=
X-Google-Smtp-Source: APXvYqy+Kc/JzChugHa2O7N8KjAl+I/OyLoIbjOh9nFctr7b4olBcfEwRvbdmaKqX8DN0bNxTqHolA==
X-Received: by 2002:a63:ec03:: with SMTP id j3mr18860179pgh.325.1564683258172;
        Thu, 01 Aug 2019 11:14:18 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id g8sm82089165pgk.1.2019.08.01.11.14.16
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 01 Aug 2019 11:14:17 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>, rcu@vger.kernel.org
Subject: [PATCH 0/9] Apply new rest conversion patches to /dev branch
Date:   Thu,  1 Aug 2019 14:14:02 -0400
Message-Id: <20190801181411.96429-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

This series fixes the rcu/dev branch so it can apply the new ReST conversion patches.

Patches based on "00ec8f46465e  rcu/nohz: Make multi_cpu_stop() enable tick on
all online CPUs"

The easiest was to do this is to revert the patches that conflict and then
applying the doc patches, and then applying them again. But in the
re-application, we convert the documentation

No manual fix ups were done in this process, other than to documentation.

thanks,

 - Joel

And in the process I learnt about get_user() and compiler barriers ;-)

Joel Fernandes (Google) (8):
Revert "rcu: Restore barrier() to rcu_read_lock() and
rcu_read_unlock()"
Revert "rcu: Add support for consolidated-RCU reader checking"
Revert "treewide: Rename rcu_dereference_raw_notrace() to _check()"
docs: rcu: Correct links referring to titles
docs: rcu: Increase toctree to 3
Revert "Revert "treewide: Rename rcu_dereference_raw_notrace() to
_check()""
Revert "Revert "rcu: Add support for consolidated-RCU reader
checking""
Revert "Revert "rcu: Restore barrier() to rcu_read_lock() and
rcu_read_unlock()""

Mauro Carvalho Chehab (1):
docs: rcu: convert some articles from html to ReST

.../Data-Structures/Data-Structures.html      | 1391 -------
.../Data-Structures/Data-Structures.rst       | 1163 ++++++
.../Expedited-Grace-Periods.html              |  668 ----
.../Expedited-Grace-Periods.rst               |  521 +++
.../Memory-Ordering/Tree-RCU-Diagram.html     |    9 -
.../Tree-RCU-Memory-Ordering.html             |  704 ----
.../Tree-RCU-Memory-Ordering.rst              |  624 +++
.../RCU/Design/Requirements/Requirements.html | 3401 -----------------
.../RCU/Design/Requirements/Requirements.rst  | 2704 +++++++++++++
Documentation/RCU/index.rst                   |    7 +-
Documentation/RCU/whatisRCU.txt               |    4 +-
11 files changed, 5020 insertions(+), 6176 deletions(-)
delete mode 100644 Documentation/RCU/Design/Data-Structures/Data-Structures.html
create mode 100644 Documentation/RCU/Design/Data-Structures/Data-Structures.rst
delete mode 100644 Documentation/RCU/Design/Expedited-Grace-Periods/Expedited-Grace-Periods.html
create mode 100644 Documentation/RCU/Design/Expedited-Grace-Periods/Expedited-Grace-Periods.rst
delete mode 100644 Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Diagram.html
delete mode 100644 Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.html
create mode 100644 Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst
delete mode 100644 Documentation/RCU/Design/Requirements/Requirements.html
create mode 100644 Documentation/RCU/Design/Requirements/Requirements.rst

--
2.22.0.770.g0f2c4a37fd-goog

