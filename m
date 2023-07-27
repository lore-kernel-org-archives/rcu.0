Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4A8FC0015E
	for <rcu@archiver.kernel.org>; Thu, 27 Jul 2023 03:04:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbjG0DEJ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 26 Jul 2023 23:04:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbjG0DEI (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 26 Jul 2023 23:04:08 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AE551BF4
        for <rcu@vger.kernel.org>; Wed, 26 Jul 2023 20:04:07 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id af79cd13be357-7656652da3cso42786685a.1
        for <rcu@vger.kernel.org>; Wed, 26 Jul 2023 20:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1690427046; x=1691031846;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2/oHz7SF+qwhqvee7uyeb/W9ByFEOLluyp4QtOuQF0c=;
        b=auwRtS+nCYvKPYlB9gt4rmjiPJplX/Wxv7LXJaMQF1Pobzrz/a2b0k/2jVu6c2MNlU
         vJAXF372FjA9k6ztO9uvdHqdv4/IJD6Y3BB/3KReMvoa8uf91X6zlPTgW8fKa4YCS+U4
         jaxmph1g8niylOTrLnegFMXnhpLUUFFdcOi+c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690427046; x=1691031846;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2/oHz7SF+qwhqvee7uyeb/W9ByFEOLluyp4QtOuQF0c=;
        b=GkqJwEleR761sbREzKMMb0f50LBxfBpYEc0U+/0AlBqhD7IdeP2jKUDvY9I3YXKXE6
         vcvIqoNdeJ5kWVPsv3qG6GKu3xBeDwkZswOLXTANUXhT6NOVWObPxlTN7rmQ8TwZ1Ib9
         vDmkZStMyUwf6/jqARtivEIX/cs0hlo8BH4Buvo5013QToki13Nx008Hy2visSGAqKbL
         Sq9t+GAbGWOgD8yPzrUOn6VDNIwpz9x2OVEkUcomJtZs52h2Z9L+ERWf/KF0UYdUlhwv
         nPxH2fNItkbbYBeacCQsIFZq+JDrpz3dFlRl9a3zLueoULXMiUnCmr9v7wEefzBQYsc/
         Kcyw==
X-Gm-Message-State: ABy/qLb8c0NspNWNcYFpXfYRpgUHSXHBzkE8e0nQriW7kjGHfKjuoBO+
        jBq+THKwI2AZdYOTZPLbjpqUDA==
X-Google-Smtp-Source: APBJJlFCsgXb/RnxmYQBOFvvpj2nZDj3UANGHwIwcUC+Kmr8vzA3/K/Mo8BEmlDuzrip7jTuHRBnpw==
X-Received: by 2002:a05:620a:29ce:b0:768:11ff:7899 with SMTP id s14-20020a05620a29ce00b0076811ff7899mr5034967qkp.64.1690427046480;
        Wed, 26 Jul 2023 20:04:06 -0700 (PDT)
Received: from [192.168.0.198] (c-98-249-43-138.hsd1.va.comcast.net. [98.249.43.138])
        by smtp.gmail.com with ESMTPSA id u4-20020ae9c004000000b00767d2870e39sm114658qkk.41.2023.07.26.20.04.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jul 2023 20:04:05 -0700 (PDT)
Message-ID: <d7d0f4c2-dd88-4ad2-8405-3c9b5d8cbb39@joelfernandes.org>
Date:   Wed, 26 Jul 2023 23:04:04 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 2/5] srcu: Fix error handling in init_srcu_struct_fields()
To:     paulmck@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "open list:SLEEPABLE READ-COPY UPDATE (SRCU)" <rcu@vger.kernel.org>
References: <20230725232913.2981357-1-joel@joelfernandes.org>
 <20230725232913.2981357-3-joel@joelfernandes.org>
 <1943e34c-3c8e-411c-a677-33f8c5b4b0e5@paulmck-laptop>
Content-Language: en-US
From:   Joel Fernandes <joel@joelfernandes.org>
In-Reply-To: <1943e34c-3c8e-411c-a677-33f8c5b4b0e5@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org



On 7/26/23 17:07, Paul E. McKenney wrote:
>> -				free_percpu(ssp->sda);
>> -				ssp->sda = NULL;
>> -				kfree(ssp->srcu_sup);
>> -				return -ENOMEM;
>> -			}
>> -		} else {
>> +		if (!init_srcu_struct_nodes(ssp, GFP_ATOMIC))
>> +			goto err_free_sda;
>> +		else
>>  			WRITE_ONCE(ssp->srcu_sup->srcu_size_state, SRCU_SIZE_BIG);
> Given that the "then" clause is a goto, what is the "else" clause doing
> for us?
> 

Not much. Agreed we can get rid of "else" and reduce indent of the
WRITE_ONCE that follows.

Would you mind making this fixup in the patch for your apply, or would
you like me to refresh the patch? Let me know either way, thank you!

 - Joel
