Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7D96C54EF0
	for <rcu@archiver.kernel.org>; Thu,  5 Jan 2023 15:51:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234704AbjAEPvM (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 5 Jan 2023 10:51:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234547AbjAEPuk (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 5 Jan 2023 10:50:40 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF36D5E0BC
        for <rcu@vger.kernel.org>; Thu,  5 Jan 2023 07:50:38 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id v2so19691383ioe.4
        for <rcu@vger.kernel.org>; Thu, 05 Jan 2023 07:50:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x5N+tQSXR3a1Z2OXWXkb2lYzYjkzFSaH5GpFM4+ANT4=;
        b=cIYPykcI4c0tm0JrP8L5kXUAhZiIVY6Aiw2+PLkjAwaIysgc8bjoVZFY0RE1LJLRVr
         oSYfQ9BkvxF/72S5ZH/KyrqHqtbI8oURpC/F/SefBNrQvfzu679lNUx9Yz8TsNjrOBi3
         ru7vsqzBZaG0Jg5DMEbQxOFlduZBSdhwFzmTJBIfdIssycK2KSGG9LIN+LGyLv2zfwQ5
         N8WBLsmWxZ2p+Bi5WNS1LZWHXjzQjsX8oB8ZpO73KTRI4H9dyJf/9+VebWZO3raUqchA
         3047OPkhL7I+UYpMu0q8PCkN0CxUcEvn6gxCEGblEKYXANzfvQL1OKLH9ohRBg5p/uaa
         Vafg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x5N+tQSXR3a1Z2OXWXkb2lYzYjkzFSaH5GpFM4+ANT4=;
        b=j0JRMT6bQ0ryLFzAdazM2e0YsYdDoFsrjwVOCqMDyxSZ5BYDbq6ck8KcAhJJUni5Fg
         fkKoDre4NAuOCus4MuE+ZLqyYKSdiOTqCBHzRD5asOzcTpJwr+V4muEo23AiuYBbgnKc
         QNpm9Ti5qWaqigYsjqL3egANePVBg1t++J4psdmIBt/+HvQ7MvMj2oi84FYkFcsDr+F+
         vtYZFhxD79EoxRm3jLnwKwcZ5SoA+dkypOzTOHZYfA18LRSKs1qA81SG+4BW8EV+A/C6
         KKYFePlHKX5D9LrKyD/TorHwAZZlp/dGFRVafjck3yY8eBSbHY8a3TgH2ITMdK62x8LQ
         6BJA==
X-Gm-Message-State: AFqh2koJL+ANthDTladU9RIZMs1a3cQTkwwvQsqL0xK6Y4MTyn/qChRk
        fSh6EsLPhWZkFUlNvBULlAeGuA==
X-Google-Smtp-Source: AMrXdXsjnlZwcoNllvJnOHFnPUEI0F8/jX8TyxLtYEQ4cLiggavuVDXW8VLsDOF9BWnHpzILm8ROpA==
X-Received: by 2002:a5d:990e:0:b0:6df:128f:ca12 with SMTP id x14-20020a5d990e000000b006df128fca12mr6265742iol.1.1672933838201;
        Thu, 05 Jan 2023 07:50:38 -0800 (PST)
Received: from [127.0.0.1] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id j2-20020a02cc62000000b00363362cd476sm12180995jaq.101.2023.01.05.07.50.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 07:50:37 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     rcu@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org
In-Reply-To: <20230105003759.GA1769545@paulmck-ThinkPad-P17-Gen-1>
References: <20230105003759.GA1769545@paulmck-ThinkPad-P17-Gen-1>
Subject: Re: (subset) [PATCH rcu 0/27] Unconditionally enable SRCU
Message-Id: <167293383749.9409.12809142428621928168.b4-ty@kernel.dk>
Date:   Thu, 05 Jan 2023 08:50:37 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-7ab1d
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org


On Wed, 04 Jan 2023 16:37:59 -0800, Paul E. McKenney wrote:
> This series removes Kconfig "select" clauses and #ifdef directives that
> are no longer necessary give that SRCU is now unconditionally enabled,
> courtesy of new-age printk() requirements.  Finally, the SRCU Kconfig
> option is removed entirely.
> 
> 1.	arch/x86: Remove "select SRCU".
> 
> [...]

Applied, thanks!

[07/27] block: Remove "select SRCU"
        commit: b2b50d572135c5c6e10c2ff79cd828d5a8141ef6

Best regards,
-- 
Jens Axboe


