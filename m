Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30830C53210
	for <rcu@archiver.kernel.org>; Thu,  5 Jan 2023 00:45:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbjAEApr (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 4 Jan 2023 19:45:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbjAEAot (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 4 Jan 2023 19:44:49 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DD7D49146
        for <rcu@vger.kernel.org>; Wed,  4 Jan 2023 16:43:09 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id d3so37796492plr.10
        for <rcu@vger.kernel.org>; Wed, 04 Jan 2023 16:43:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tv4XxWzlc+KkvsWck6iKHS0aGLu9UROX1I0JLU1j3G0=;
        b=YbCPGdRn5GRl5GA3sRGZFyLnbsgHCC4HEZDRkzTsRUiBYHdTyNIeLkd9DRdYaltJdu
         R5Ghr/VMFTa1ETvMH/5KkCaZnzzLpgnHxc9Mq17olANx6GeUlZF4c3a81jP1XDo0dkze
         G+lPFE7Q5lHMaqAKnVbHwee44CBK8lqd+2UUbqvfWT48vHYOWnnDOAgqxWKiUFPT6Bl2
         aQ8hKsDkkqcUPa//YBWEx99eE5bWGNQ0iLljdouNzmKeqUcsmFQgjQHwzzLGnf5lYlQB
         dyrVzjpAvQnFMEeUUpd/VfVLv7k/44aCOtUNYbEIHW7i0wGtNPqbKptuwvA1GRQInK4E
         qYyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tv4XxWzlc+KkvsWck6iKHS0aGLu9UROX1I0JLU1j3G0=;
        b=dGZAnfXveaz+CKWoBCiTJmEtBt1PP4esVNCCdJRCQt3HixzUX1rTh/rzDpBQRWazkM
         q4ISSeRjp2XQn/dcCrYdnGaYpepLpL+hEgshxEwNMSKKfffHyKNT+zk1ktebzek/bflM
         VJvJzHeQ6lElD5yaaQW2iya1tCKnRgEJnvZ4+l4Jcneuzc4IJuBusuyI7dVeKRuE+Gsu
         xY9R+vE8QIsDDTqW4mHN4NT0xzCHkF7XyEs8sxmKNsuXOzSekF6MPPGfFr72qGTsoWAd
         +jL6sZbK7z8qLtroemcf7ZKd8gZX7DlWxRXNrRHH9eWkR0FdsxcqFLX27FC6UCpBQkc+
         wY+Q==
X-Gm-Message-State: AFqh2kqTEYng/GFtbns3dkiJ1BH4q2Pc8ANpzJ9EOH3oh4xYCGYylndw
        TKhz9rDaMOru9+6BELmt59cYCyfRWXw6rX5f
X-Google-Smtp-Source: AMrXdXtpXcKKU0u9CdeIo9cWE+harAer2+Dw/8LAE0nO384r5K4bs6Z8Gxi87gFLRRQBJ79CCSlQLg==
X-Received: by 2002:a17:903:3311:b0:189:d0fa:230f with SMTP id jk17-20020a170903331100b00189d0fa230fmr12987588plb.4.1672879388922;
        Wed, 04 Jan 2023 16:43:08 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id jd6-20020a170903260600b00192a8d795f3sm11780565plb.192.2023.01.04.16.43.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Jan 2023 16:43:08 -0800 (PST)
Message-ID: <1a9d0cdf-d39e-7eb5-39dd-3e425016c579@kernel.dk>
Date:   Wed, 4 Jan 2023 17:43:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH rcu 07/27] block: Remove "select SRCU"
Content-Language: en-US
To:     "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, linux-block@vger.kernel.org
References: <20230105003759.GA1769545@paulmck-ThinkPad-P17-Gen-1>
 <20230105003813.1770367-7-paulmck@kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230105003813.1770367-7-paulmck@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On 1/4/23 5:37 PM, Paul E. McKenney wrote:
> Now that the SRCU Kconfig option is unconditionally selected, there is
> no longer any point in selecting it.  Therefore, remove the "select SRCU"
> Kconfig statements.

I'm assuming something earlier made this true (only CC'ed on this patch,
not the cover letter or interesting btis...), then:

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe


