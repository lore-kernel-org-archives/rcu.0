Return-Path: <SRS0=LF1p=UZ=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2D04C48BD6
	for <rcu@archiver.kernel.org>; Wed, 26 Jun 2019 20:07:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2E4D208E3
	for <rcu@archiver.kernel.org>; Wed, 26 Jun 2019 20:07:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cc4/pgZ5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726289AbfFZUHH (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 26 Jun 2019 16:07:07 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:45805 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbfFZUHH (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 26 Jun 2019 16:07:07 -0400
Received: by mail-oi1-f195.google.com with SMTP id m206so67445oib.12;
        Wed, 26 Jun 2019 13:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L1KY2VS0YX2JdGgipHxdRkqGaqq8aqJuC6oZGy9IsNU=;
        b=Cc4/pgZ5zXQyZ7Y4l84WddUaV+snmGbt/sElj+sYiPgG0MlniKIiOJ/BiWsBY9IAE6
         t67iADTbByUhEvyhg75qMmvuJcjf0MHBTB83AIRknvSCe0YeCc7SpKH55KWvHAGQB7eT
         Up2eJpRPvB9cA7v78hD/r4Sk9evxzhyIYl6v383Soo+WSRGIk0jE05qYIfmQK6eZSoUi
         U5As8g2AU5+S2t/yukiQjg20ri0x7Cr88RwwAsUJyEgw4qTRkpcV7halXDf0w7Ed5pky
         gEFtOD8gawn4u9sZGfsMrwSreKtS6b78C1cSV4gdmpjlr1biRNbWAI2nboriTPU1WdZn
         7xNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L1KY2VS0YX2JdGgipHxdRkqGaqq8aqJuC6oZGy9IsNU=;
        b=Elz0TZI8MrGs3c98G+/4Ts0EC63a5ZOtgq1uxjR7D5cuWMUdSGaSh+yYVda6QXsAhn
         ZJEPfNFwCsCFwbQ9CQB4/PGL9zz6B8TAGh4HeOescLnrFp7ofmrauzWOf7RDmUukx3cw
         P8IBE+aVOSzWi9PMm4oaEOyWoItUv7lJlcPqFOLa1xwOPjxJkPRDYQpXs82mXd13I4KJ
         ZIEO8Nr7J4vmuDS2X0nvyX0GNWfPd/NyHLBA6xESW2OonOd9xi4CLFz69dEAtk+A/wqw
         5xGkWAFNMRrFuVGHMNPXK0S7w/fLSgkI4mkE/JmfacHLTP48OPx+IS6CRV71RKncH+tK
         14ZA==
X-Gm-Message-State: APjAAAU52fOUpJe3MUQ7T4yZVWB49IMj64FX2J9psqTo7F66XfId0uJA
        hmG+9Onzr0ioeWUv7uqxHlEzgXciJUA=
X-Google-Smtp-Source: APXvYqxiJHN5jv7ob8Hcjl0X7AMBj8zqubPkfsJTuvTPmurBTwxlzu0zwYGCya+V8yHITmk8+Dzv7g==
X-Received: by 2002:aca:cf51:: with SMTP id f78mr130419oig.10.1561579626623;
        Wed, 26 Jun 2019 13:07:06 -0700 (PDT)
Received: from rYz3n.attlocal.net ([2600:1700:210:3790::48])
        by smtp.googlemail.com with ESMTPSA id l15sm6952771otr.38.2019.06.26.13.07.05
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 26 Jun 2019 13:07:06 -0700 (PDT)
From:   Jiunn Chang <c0d1n61at3@gmail.com>
To:     skhan@linuxfoundation.org
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        rcu@vger.kernel.org, linux-doc@vger.kernel.org,
        paulmck@linux.ibm.com, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, corbet@lwn.net
Subject: [Linux-kernel-mentees][PATCH v5 0/5] Documentation: RCU: Convert to reST
Date:   Wed, 26 Jun 2019 15:07:00 -0500
Message-Id: <20190626200705.24501-1-c0d1n61at3@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190626191249.21135-1-c0d1n61at3@gmail.com>
References: <20190626191249.21135-1-c0d1n61at3@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

This patch series is the initial conversion of the RCU documentation
section.  This includes reST markup and renaming txt files to rst.  For files
converted, internal links have been created.  Checkpatch was used to leverage codespell
for any spelling errors.  Each patch in the series has been compiled and reviewed
for warnings and errors.  Patches can be bisected.

The changes make in v5 include:
  - add reviewed-by tags

The changes made in v4 include:
  - Change links in rcu.rst to the path in documentation section
  - Maintain the original name of the txt files

The changes made in v3 include:
  - correcting markup to maintain even more of the original text
  - correcting markup for line breaks
  - combining all file renaming into one patch
  - add reviewed-by tags
  - add required public list to CC

The changes made in v2 include:
  - correcting markup to maintain as much of the original text as possible
  - correcting markup to reduce reader context switching
  - breakout file renaming into individual patches in the series

>8---------------------------------------------------------------------------8<

Jiunn Chang (5):
  Documentation: RCU: Convert RCU basic concepts to reST
  Documentation: RCU: Convert RCU linked list to reST
  Documentation: RCU: Convert RCU UP systems to reST
  Documentation: RCU: Rename txt files to rst
  Documentation: RCU: Add TOC tree hooks

 Documentation/RCU/{UP.txt => UP.rst}          | 37 +++++---
 Documentation/RCU/index.rst                   | 19 ++++
 .../RCU/{listRCU.txt => listRCU.rst}          | 38 ++++----
 Documentation/RCU/rcu.rst                     | 92 +++++++++++++++++++
 Documentation/RCU/rcu.txt                     | 89 ------------------
 5 files changed, 156 insertions(+), 119 deletions(-)
 rename Documentation/RCU/{UP.txt => UP.rst} (84%)
 create mode 100644 Documentation/RCU/index.rst
 rename Documentation/RCU/{listRCU.txt => listRCU.rst} (92%)
 create mode 100644 Documentation/RCU/rcu.rst
 delete mode 100644 Documentation/RCU/rcu.txt

-- 
2.22.0

