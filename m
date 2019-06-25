Return-Path: <SRS0=oVcv=UY=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ED7FC48BD5
	for <rcu@archiver.kernel.org>; Tue, 25 Jun 2019 06:26:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47B1E20659
	for <rcu@archiver.kernel.org>; Tue, 25 Jun 2019 06:26:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g0QAWFUI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729251AbfFYG03 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 25 Jun 2019 02:26:29 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:41319 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729059AbfFYG03 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 25 Jun 2019 02:26:29 -0400
Received: by mail-oi1-f195.google.com with SMTP id g7so11656536oia.8
        for <rcu@vger.kernel.org>; Mon, 24 Jun 2019 23:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4GBBKoiFmb6Nevyn+zO+DhtsVC7JYsfFW8rnMSFI5Iw=;
        b=g0QAWFUI6+5vFN6DqiFPJbjgSaYd2oXaq5C36JQ1RDrqSKntLlSZIIF3Kx2JZ0zggD
         Hf1CrDTV09AgHD9pYg+6rzsifRczOdbgzAaNjYbf0SqqRGWj1xzUt3L/q+weq7qEAJif
         RGTL+3dii1GSqS35d5bOQIJTHSX3IDpdQRbMmH5ZJucosegi/JInJvEEz+x5VVhwmzxK
         /ycAdHhzDMmmLMjqpkMIuWgUDL+vzbb4gpsdegpX+q/fFwH9Q4CYQEVMmtr4zAVj888D
         ZbwpqzvayFS6ie+v1xtNVbRlSvktgXuSXhm9ysKB0CNWXFNyUYQyLoB7gJrkiX9je2RD
         bLkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4GBBKoiFmb6Nevyn+zO+DhtsVC7JYsfFW8rnMSFI5Iw=;
        b=otAiltj0FGjlkfv0k3qGeWA5ddAcYCp5FOMVugwveO6vTYCCxy3nx7gHBGjgeSkfl4
         kFAp6m/Vh7YdRp50dbHe2m5WFJTuPu95anp8UuddKqY88k+v9qrNXXHLGMp4bUyWDbbb
         wMKoLHgyelJM8+yS1IL9mm8hPDtY8QDXYvZ0bH+F+bE6KIZRl6COI3mSlGMUwTpeoPha
         TscxEvZZ8cyulPvYs0IX1n/KzeE7GstyHbvUiemGvwwJ8jnCDQgB+pPfRA2E2mXjNdH0
         0GluSX7WGO9dP3KEJ6zjirLezf6/6VsAy1oyxE/gVx24ARrr/m6zcfyODrjcNeQzhik9
         HYRw==
X-Gm-Message-State: APjAAAWpWt996gvUeFLdqUqEezGh1BpzlIDeFJu6j+OOczWEpeJWmYpz
        Px55gvVj2PCKzKSG7aDiHCk=
X-Google-Smtp-Source: APXvYqzS/jPbErR1eYFQ9ZtSf2UIsMVFdI95LwRta55szgk1GezTfuTpAaF5GICnW7IY5tD8jJQPLA==
X-Received: by 2002:aca:ba02:: with SMTP id k2mr12174797oif.70.1561443988746;
        Mon, 24 Jun 2019 23:26:28 -0700 (PDT)
Received: from rYz3n.attlocal.net ([2600:1700:210:3790::48])
        by smtp.googlemail.com with ESMTPSA id e4sm5050183oti.64.2019.06.24.23.26.27
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 24 Jun 2019 23:26:28 -0700 (PDT)
From:   Jiunn Chang <c0d1n61at3@gmail.com>
To:     skhan@linuxfoundation.org
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        rcu@vger.kernel.org, paulmck@linux.ibm.com, josh@joshtriplett.org,
        rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com, joel@joelfernandes.org, corbet@lwn.net
Subject: [Linux-kernel-mentees][PATCH v3 0/6] Documentation: RCU: Convert to reST
Date:   Tue, 25 Jun 2019 01:26:21 -0500
Message-Id: <20190625062627.26378-1-c0d1n61at3@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190623081413.7095-1-c0d1n61at3@gmail.com>
References: <20190623081413.7095-1-c0d1n61at3@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

This patch series is the initial conversion of the RCU documentation
section.  This includes reST markup and renaming txt files to rst.  For files
converted, internal and external links have been created with cross-references.
Checkpatch was used to leverage codespell for any spelling errors.  Each patch
in the series has been compiled and reviewed for warnings and errors.
Patches can be bisected.

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

>8-----------------------------------------------------------------8<

Jiunn Chang (6):
  Documentation: RCU: Convert RCU basic concepts to reST
  Documentation: RCU: Convert RCU linked list to reST
  Documentation: RCU: Convert RCU UP systems to reST
  Documentation: RCU: Rename txt files to rst
  Documentation: RCU: Add links to rcu.rst
  Documentation: RCU: Add TOC tree hooks

 Documentation/RCU/index.rst                   | 19 ++++
 .../RCU/{listRCU.txt => list_rcu.rst}         | 38 ++++----
 Documentation/RCU/rcu.rst                     | 91 +++++++++++++++++++
 Documentation/RCU/rcu.txt                     | 89 ------------------
 Documentation/RCU/{UP.txt => up_rcu.rst}      | 37 +++++---
 5 files changed, 155 insertions(+), 119 deletions(-)
 create mode 100644 Documentation/RCU/index.rst
 rename Documentation/RCU/{listRCU.txt => list_rcu.rst} (92%)
 create mode 100644 Documentation/RCU/rcu.rst
 delete mode 100644 Documentation/RCU/rcu.txt
 rename Documentation/RCU/{UP.txt => up_rcu.rst} (84%)

-- 
2.22.0

