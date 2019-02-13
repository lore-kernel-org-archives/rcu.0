Return-Path: <SRS0=GQnZ=QU=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD81DC43381
	for <rcu@archiver.kernel.org>; Wed, 13 Feb 2019 22:31:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 721432082F
	for <rcu@archiver.kernel.org>; Wed, 13 Feb 2019 22:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550097119;
	bh=5e9nyGgeJbTClkNilVTelqAakOrUHsM4imp4VVeaPyg=;
	h=Date:From:To:Subject:List-ID:From;
	b=EdUCw3opCw5SuaPkp4qNfyTcSLfHFaWQ2cnNZw66Ne8h+TjKUMTnypEKOUbjzGdup
	 WcXcX79ns0JN5wVsC09IipDcRo4Gd9J+6sn57xVNB5h8g1kCmRd5DwsizVBClPtbNb
	 RwCzvxJ5N02WCS8JeXeHf2CqjgXUWGS3N+9ZcfnA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728731AbfBMWb7 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 13 Feb 2019 17:31:59 -0500
Received: from mail-it1-f177.google.com ([209.85.166.177]:53248 "EHLO
        mail-it1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728708AbfBMWb7 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 13 Feb 2019 17:31:59 -0500
Received: by mail-it1-f177.google.com with SMTP id x131so8745543itc.3
        for <rcu@vger.kernel.org>; Wed, 13 Feb 2019 14:31:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=YMG9wtGXVqPZjnOKrkyODVQVkIGZzvk+L2/QJenOM5A=;
        b=d5YFvbYqOO8N4Z98OGtg8mf/pnknC/mqWCVBhEWakac7pAa0VVnT0lnTaLy28YShB3
         ilpKXCVC6UsHvqQegtXDBjYWfUO4ujWZlOc9JY8mDMFy8jREAIJ+t3tUN1e7sxOf9lz3
         7O02oCOuS0uSRRESBm2Yb8jJD7akAxjE/6fGo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=YMG9wtGXVqPZjnOKrkyODVQVkIGZzvk+L2/QJenOM5A=;
        b=tsTwKBI7grt0DVv9mTb4eeiprNEZDT0b8rR5nyznNYD2xdnFvNCIT1F7xeVU3WbUam
         2hMl4w2liy37mKmigUwdYpcQ8/uWqwu3qZA0iuwH9lv0adknxiwgS0Hqp7XFdps5OpEz
         MehOriki21VsI0/MSEcrYgJyZ+v3ZF3CRq+yRXLLqG3cKMRQKEqRg0L3FrIB1Fauh0Jb
         wlO+PS+mA3O9K69yAID9Me3bQAHAcpmbxFR+TlzRIwkDSV0Gufcd+U4AXTdELb5VCwrw
         juyrcYN52ODnUt571Db1TrFtohaK027VW8UpfmAYm8ybHULqv4zQbQDztz8RuoExSGWP
         8ELg==
X-Gm-Message-State: AHQUAubbXfYhW72GT+/1rfqOyxWmpCeTiBvPyJUIWM5MNdM4qi38/E9d
        gOV6h7+snucr9oGlAfLki87w4JbopVMABQ==
X-Google-Smtp-Source: AHgI3Iarh4hxShPVVR9LjshcJlKzXbFg4eQ6M/WVd/RT0BkcS4Vc2gcRxVJLo/EmD7+8BaVg/m/pYA==
X-Received: by 2002:a02:c4a:: with SMTP id g71mr299414jad.25.1550097117688;
        Wed, 13 Feb 2019 14:31:57 -0800 (PST)
Received: from chatter.qube.local ([184.75.214.131])
        by smtp.gmail.com with ESMTPSA id n124sm319224itn.4.2019.02.13.14.31.56
        for <rcu@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Feb 2019 14:31:57 -0800 (PST)
Date:   Wed, 13 Feb 2019 17:31:55 -0500
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     rcu@vger.kernel.org
Subject: Test archiver service, ignore
Message-ID: <20190213223155.GB20543@chatter.qube.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hello:

The archiver service on lore.kernel.org/rcu was not properly configured, 
so it didn't receive the messages sent to the list. I believe I've fixed 
the problem, but to verify this, I am sending this message to confirm 
delivery.

-K
