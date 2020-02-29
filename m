Return-Path: <SRS0=nDYm=4R=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AB5EC3F2C6
	for <rcu@archiver.kernel.org>; Sat, 29 Feb 2020 16:37:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01A8E20873
	for <rcu@archiver.kernel.org>; Sat, 29 Feb 2020 16:37:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IUlTlrkw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727242AbgB2Qg4 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sat, 29 Feb 2020 11:36:56 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39685 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727119AbgB2Qg4 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sat, 29 Feb 2020 11:36:56 -0500
Received: by mail-pg1-f195.google.com with SMTP id s2so2303118pgv.6;
        Sat, 29 Feb 2020 08:36:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=chLyyboKxljeNbWjn+Ihw3+ifU4bM69LKhYN2hSreuI=;
        b=IUlTlrkwPmIJlTDZCm8NooTvS1aj0bTIUqbrB1RFkSewUowZNN555WF3p6X3dXPWmI
         Qjt85wVnca3sfgx/WaqoAv5FkqdxDOrQ27co6aPBY8CXvBa4AL4p4JkrBEZhRPYALgof
         nflEEB93Un3JA1LIzCDWbPRdNvaO3XQgbEHH83UW2EGXCSmsBeOOZxNGP6vXpIPo1YBP
         yYPLfnu/pEs64oqJ9gLFp5aUcQiULW03rH/L3cXkvlgUUWUgbdnMV0hbJOmxaztkVFcG
         HBRYxeAz2YUbULH0TFMyxMb/oSIIsH8OZln+gaW1qwPo6iHi2GEii3Xfm1x0Hxz/0HTh
         C2Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=chLyyboKxljeNbWjn+Ihw3+ifU4bM69LKhYN2hSreuI=;
        b=HFQxrDrwzO3Q3zaJxMReJn5HU6ZMMT1MjpnEiCpB7+Y8UiOCf3lFQ26uBx4Ek5Do6r
         64Vxz70UC5YsNRiOyf8RXScZ1MRM7saRlK1upWHTmZ7MGV2vur6TNE9ncJ/fkT9/pR75
         yZdEhyS6NNWeTDUv2HXZ/9uYbM7ORnGGxi1xonqWHUh6qBBQ83cHhPlrcRltD5f5xDv8
         kIOcsS6+y8iRaLVRqGtJbeyC9VBtGw5s/Lc3+BEEChczIBhrVUqEzdCDqdMMMltsVHs0
         yBIBlXs3VVCV3rgnQJ2p42HPRbd7+1O2Mf1oBjynsms+66wR8oRi9yptob0pt1g2QktF
         Qyeg==
X-Gm-Message-State: APjAAAWnAJVwVkNDmJixJF8LIeYXK7iU+0h1unS4Ush9YfAWO5GcxSnY
        sWVdrtPkY7rqpvEkf3aMntI44aHVLxFBG6cr
X-Google-Smtp-Source: APXvYqx0LOEKyONlMpZ8BncOiwY/mdIa4tKsVKADHgnTl42PeMJx4fVUhd+rlPEBwy9g3Bek+jaSjw==
X-Received: by 2002:a62:1c95:: with SMTP id c143mr9585082pfc.219.1582994214624;
        Sat, 29 Feb 2020 08:36:54 -0800 (PST)
Received: from [192.168.0.108] ([103.46.200.19])
        by smtp.gmail.com with ESMTPSA id d23sm15450153pfo.176.2020.02.29.08.36.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Feb 2020 08:36:54 -0800 (PST)
Subject: Re: [Linux-kernel-mentees] [PATCH v3] doc: Convert rculist_nulls.txt
 to rculist_nulls.rst
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200227180656.15187-1-amanharitsh123@gmail.com>
 <20200229075653.2fd7ae3e@lwn.net>
From:   Aman <amanharitsh123@gmail.com>
Message-ID: <7d28ad4d-6b7a-74a6-699e-b8b614844ff3@gmail.com>
Date:   Sat, 29 Feb 2020 22:06:43 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200229075653.2fd7ae3e@lwn.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On 29/02/20 8:26 pm, Jonathan Corbet wrote:
> On Thu, 27 Feb 2020 23:36:53 +0530
> Aman Sharma <amanharitsh123@gmail.com> wrote:
>
>> This patch converts rculist_nulls from .txt to .rst format, and also adds
>> it to the index.rst file.
>>
>> Major changes includes:
>> 1) Addition of section headers and subsection headers.
>> 2) Addition of literal blocks which contains all the codes.
>> 3) Making enumerated list item by changing X) to X. where X is number
>>     like 1,2,3 etc.
>>
>> Signed-off-by: Aman Sharma <amanharitsh123@gmail.com>
>> ---
>>   Documentation/RCU/index.rst         |   1 +
>>   Documentation/RCU/rculist_nulls.rst | 179 ++++++++++++++++++++++++++++
>>   Documentation/RCU/rculist_nulls.txt | 172 --------------------------
>>   3 files changed, 180 insertions(+), 172 deletions(-)
>>   create mode 100644 Documentation/RCU/rculist_nulls.rst
>>   delete mode 100644 Documentation/RCU/rculist_nulls.txt
> When you put out multiple versions of a patch, it's always good to say
> what has changed; you can put that information right after the "---" line
> above.  That's even more true if you send two versions within minutes of
> each other; recipients will want to know what is going on.
>
> Thanks,
>
> jon

Alright, I will make sure to always mention the changes between the 
subsequent version of patches.

Here, the reason for a v3 patch is to fix the typing error in the commit 
message, there was a duplicate line in commit message of patch v2.

