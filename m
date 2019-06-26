Return-Path: <SRS0=LF1p=UZ=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A584C48BD6
	for <rcu@archiver.kernel.org>; Wed, 26 Jun 2019 19:12:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5977B208E3
	for <rcu@archiver.kernel.org>; Wed, 26 Jun 2019 19:12:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RJ8+M2yB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726271AbfFZTMx (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 26 Jun 2019 15:12:53 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:38139 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726223AbfFZTMw (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 26 Jun 2019 15:12:52 -0400
Received: by mail-oi1-f196.google.com with SMTP id v186so2800409oie.5;
        Wed, 26 Jun 2019 12:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gNO8GN//57KTmLhLnuVE9rlZ5VXqaFSEVj6N5XDBgAU=;
        b=RJ8+M2yBhjD7Ysn0oL693Cz0omog71qgJgXDDvKHK7SKTSb7TACKYSic0RU8yCv587
         7QwVRPHgpLXWbd5gob2HUoK3X92JiRq7lrF9TXftGLvQCqyUkgqi/HaTOCamyN6XDPKa
         G94av6ZPQ0Gi82nKHN88O+yib2rFd8vMu3tYctTASGfp9JE9NL2uePaxBxh+MHkTc69z
         CKGqVn5EoYbd4MIvdE6zXHVoF1rcXQmCO2IxE3g0gUldMluAAy64cKpZRCrhMNDAWYQs
         FasqozD7jE2srg+gvKm47/SV/nxCjoWYPwicghHLY2dp6fOLxcs2CcxU80PapuFvbnjM
         qydQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gNO8GN//57KTmLhLnuVE9rlZ5VXqaFSEVj6N5XDBgAU=;
        b=UUvBuBVZhrqG+NxsJ9es79ygCAb6KDvjNGYO4JKqtieh3AfdLw1iXfUzuhLWieyj87
         iiiJRWDdeEKrpvsOofgH2BRkxZMZSIO3XObYeO4GyBu8D6LQLCQZtx8DU4v8GhD39qPB
         ZRKG6n8KH8uEHc2BGoQHDyLeAif7T+O+gC6lT8j5FYps7lrNNVJYgMz6TV6g7ehXe6ir
         IZnLBfPakuW/GdMqi1ZOs1DlvJFqNqFN89QR/f+PCAmSsiYFapPmVzciznLrKOLjLTol
         EpVLMRN7VOH0skp83NPNBeGPc8atyal0wZsST9I0UDi2/tXpOtDVF2u4neO3JbraCpiZ
         GJBQ==
X-Gm-Message-State: APjAAAXuFxyO8X1l52ZgZ2kOlLEI7pg+FQvAztxdgSsiYFSiS8qc7LCK
        9h1O6fSVucuxcGBTy4fVy60=
X-Google-Smtp-Source: APXvYqxjWxrCwqXS1TuQIlcilXmSd4FAdGCpOgrw7asgMFCLuq7IUUUNy4bmtaYavc3GBOxG/RQP6A==
X-Received: by 2002:aca:a896:: with SMTP id r144mr382211oie.105.1561576372053;
        Wed, 26 Jun 2019 12:12:52 -0700 (PDT)
Received: from rYz3n.attlocal.net ([2600:1700:210:3790::48])
        by smtp.googlemail.com with ESMTPSA id e16sm7886679oih.9.2019.06.26.12.12.50
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 26 Jun 2019 12:12:50 -0700 (PDT)
From:   Jiunn Chang <c0d1n61at3@gmail.com>
To:     skhan@linuxfoundation.org
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        rcu@vger.kernel.org, linux-doc@vger.kernel.org,
        paulmck@linux.ibm.com, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, corbet@lwn.net
Subject: [Linux-kernel-mentees][PATCH v4 0/5] Documentation: RCU: Convert to reST
Date:   Wed, 26 Jun 2019 14:12:44 -0500
Message-Id: <20190626191249.21135-1-c0d1n61at3@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190625062627.26378-1-c0d1n61at3@gmail.com>
References: <20190625062627.26378-1-c0d1n61at3@gmail.com>
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

