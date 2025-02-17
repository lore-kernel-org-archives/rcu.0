Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC82D1FECAA;
	Mon, 17 Feb 2025 09:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739783928; cv=none; b=R9iu7j6C2GtzvtA8FcoKCdkIEJy/h1sRwQ/zmxRMnYNMxBOrV0VxECDr4scuVQCpqh6/Od1PBEnkfLrC4Qh5ao5Fk+epPIEBtc5rgN9FydwlsiGT+Im9R1Y0a0aj5BKsMGwvnLgngWRJ9RSnkdFFBqIeCaCrudpYeqJvy72kYkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739783928; c=relaxed/simple;
	bh=VMO5p6So5NNOOOAjvza3C7u12c5b6yqqan40IG58d48=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iRFds5ufkdO92nviWtcKfyVRcHbT3xDo0OIf5xVExSuP7hW9afLl2JB4bJpB08xOp0EcI2DYoBmhtGdjllBUiYPO8ji08gPSy3b6kG7noOLaEvxehWPc/Y8mlICCvSgaAZQqBY5Ucvmpe8XV6TaZITGRqNR6b1uVNOCYOu4OFIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K8qEKk3P; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K8qEKk3P"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5e058ca6806so1670427a12.3;
        Mon, 17 Feb 2025 01:18:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739783925; x=1740388725; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:reply-to:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=n62fNv7NFCu/xB54nXunu1soBGYZFvAypckJsJSeI94=;
        b=K8qEKk3Po7cvqP8lA/9i2mgUqYFQljjzEL4AlC0LSg+Zm3gSkywGY2JMOR3HdEkjYa
         S7j+G3YXXEpMSPVeBz3gVTIzjhGe9aNeBZC0D+nvmjaY7f03AnVXXxTMX5lgLARn0oqb
         t5M8JKB7/VxN/IOaRaeh9aJQyxy/f3AGbdYCQYQeTpE4aKkOl9SCAU8Jdvp0rfuKZzMg
         BlFnkZAFrTmQDpO5+iCLJyO/Di+0bBN9tiubq8HPmd8T1kLLBBpOFXjGxu48YrKtqDkK
         eyGZTK4L8iRvHIWTY1iVx/rwLPbHik0epXuycY2xq4F5XUKIl0S5/3eiIMD49ScKS8OY
         zZyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739783925; x=1740388725;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:reply-to:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n62fNv7NFCu/xB54nXunu1soBGYZFvAypckJsJSeI94=;
        b=JfGrPtYPif21LaKbs7JsaDa6LRKuzL3HxZZl5EiPW+uw5r4VyXE3h2OVGP6XEO7btO
         n9Qtjcrg68NBu5YSgxFHum2PuhIFQW449mMVBNEHmUMW7JKVTJXjBeAILjmAGQcMD1NY
         hZKpaNdhoVibT1LWN7sR3DlvpmOEz7pSZ8mK6+JOmJroA3dGNsxdHovSiqSxcsX2pzmH
         8vMtLrnH0E6oDS1YF1f501edK0EaYdH33oWfoIpREBmfNMUUy2lctVxlhOa9upCdoXeZ
         Drzkqv29F1pl9Zl+sDydev1Tmps4kks+/auF1xSbqr0QG1IJe0XfII1HFEk4Q9lkdmR+
         yYdw==
X-Forwarded-Encrypted: i=1; AJvYcCUsSyfv9F1uEb3QXUSYqvhOzD61h7XOXLD1Ld60Tw6XHujjOF2+eu7CrbZ/KtV8l4K4tzIfxg+GvmM=@vger.kernel.org, AJvYcCXyHm76zLaP9NJjKV0ez4AC/Ucd0hL8kVyKlVnTDA7rWRYTLYwuRYOPoYkPEtirUsIY23Cu@vger.kernel.org
X-Gm-Message-State: AOJu0YyWCcWR+2ACBzlV3ynuESlq4e7hV7Q7P7HE58pVOVZt9PAVdD2Y
	NMtHdCjooLUvuSI0UPh9jTEdW5n2cvSDdozteCmpTqVGUmPqgtHLqD9RIfGL
X-Gm-Gg: ASbGncvfAX7nOKHdGIWwKi4QbW7WykH7+/tp/Jz/0qlBRJ3JNv5iiyKOIuJfKN9ZAAW
	sUmIcY7z+z9BZb/mIM5+yAOcGVBkBDinqSe7OarBP33bHLhoqBJVFVDdjaMz+1c6Uwg6iPypH0s
	XbyTb52uW/l7nTURAO1ZFE1DTEcOLOp9JUDEi6+KomB1wQxH+ivc8ZxvLPQ5KX0U+iggtJsq6vT
	GqcYo05hd8K5xqR/nLwZX71TX3s4xGgQTrd/bS7zNwmnGCSKinBf9xnFxgqQBIdb2/03wDZxoC7
	lAha4xP/nQmXJvk=
X-Google-Smtp-Source: AGHT+IE2E9lO5VjWXoTPQk1z9mon933Huf6Df4hybWkd3x+zi4O5zyrYGqMBtbJOUhHeA6yir+zm8g==
X-Received: by 2002:a17:907:7842:b0:ab6:ef94:6054 with SMTP id a640c23a62f3a-abb70bcab94mr899291466b.33.1739783924520;
        Mon, 17 Feb 2025 01:18:44 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb88c69c1bsm319029966b.110.2025.02.17.01.18.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Feb 2025 01:18:44 -0800 (PST)
Date: Mon, 17 Feb 2025 09:18:42 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Alan Huang <mmpgouride@gmail.com>
Cc: Wei Yang <richard.weiyang@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
	paulmck@kernel.org, frederic@kernel.org, neeraj.upadhyay@kernel.org,
	rcu@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH] doc/RCU/listRCU: fix an example code snippets
Message-ID: <20250217091842.emsz6graccyjkzgf@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20250101082306.10404-1-richard.weiyang@gmail.com>
 <Z7Ka8Z5RS_OwyL_G@Mac.home>
 <CDB3A2E0-A891-491E-9F7D-F09843F1A3E3@gmail.com>
 <20250217074100.2wyy6akdr2j464wx@master>
 <C6141FF0-5892-439E-9475-43BEF31DFF8E@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <C6141FF0-5892-439E-9475-43BEF31DFF8E@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Mon, Feb 17, 2025 at 04:02:53PM +0800, Alan Huang wrote:
>On Feb 17, 2025, at 15:41, Wei Yang <richard.weiyang@gmail.com> wrote:
>> 
>> On Mon, Feb 17, 2025 at 10:22:53AM +0800, Alan Huang wrote:
>>> On Feb 17, 2025, at 10:12, Boqun Feng <boqun.feng@gmail.com> wrote:
>>>> 
>>>> Hi Wei,
>>>> 
>>>> The change loosk good to me, thanks!
>>>> 
>>>> I queued the patch for futher reviews and tests with some changes in the
>>>> commit log (for title formating and a bit more explanation), please see
>>>> below.
>>>> 
>>>> Regards,
>>>> Boqun
>>>> 
>>>> On Wed, Jan 01, 2025 at 08:23:06AM +0000, Wei Yang wrote:
>>>>> The example code for "Eliminating Stale Data" looks not correct:
>>>>> 
>>>>> * rcu_read_unlock() should put after kstrdup()
>>>>> * spin_unlock() should be called before return
>>>>> 
>>>>> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
>>>> [...]
>>>> 
>>>> 
>>>> ------------------>8
>>>> Subject: [PATCH] doc/RCU/listRCU: Fix an example code snippets
>>>> 
>>>> The example code for "Eliminating Stale Data" looks not correct:
>>>> 
>>>> * rcu_read_unlock() should put after kstrdup(), because otherwise
>>>> entry may get freed while kstrdup() is being called.
>>>> 
>>>> * spin_unlock() should be called before return, otherwise the
>>>> function would return with the lock of the entry held.
>>>> 
>>>> Hence fix these.
>>>> 
>>>> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
>>>> Link: https://lore.kernel.org/r/20250101082306.10404-1-richard.weiyang@gmail.com
>>>> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
>>>> ---
>>>> Documentation/RCU/listRCU.rst | 3 ++-
>>>> 1 file changed, 2 insertions(+), 1 deletion(-)
>>>> 
>>>> diff --git a/Documentation/RCU/listRCU.rst b/Documentation/RCU/listRCU.rst
>>>> index ed5c9d8c9afe..8df50fcd69fd 100644
>>>> --- a/Documentation/RCU/listRCU.rst
>>>> +++ b/Documentation/RCU/listRCU.rst
>>>> @@ -348,9 +348,10 @@ to accomplish this would be to add a ``deleted`` flag and a ``lock`` spinlock to
>>>> rcu_read_unlock();
>>>> return AUDIT_BUILD_CONTEXT;
>>>> }
>>>> - rcu_read_unlock();
>>>> if (state == AUDIT_STATE_RECORD)
>>>> *key = kstrdup(e->rule.filterkey, GFP_ATOMIC);
>>>> + spin_unlock(&e->lock);
>>> 
>>> According to the above quick quiz, we should return with the lock held.
>>> 
>> 
>> Thanks, I think you have some reason.
>> 
>> If my understanding is correct, the example here is to emphasize we could
>> still access the value out of critical section but with spinlock held.
>
>This example is intended to highlight how we can eliminate stale data.
>

Yes, you are more accurate.

>> 
>> In current example, we don't return e(struct audit_entry) from
>> audit_filter_task(). So no one suppose to release the spinlock again. This
>> looks to be a mistake.
>
>Then the example code should return e instead. ( *key is also undefined)
>

So you prefer a version with e returned?

Boqun

What's your preference?

>If you have some time, I’d recommend [1]
>
>[1] Using Read-Copy-Update Techniques for System V IPC in the Linux 2.5
>Kernel
>

Thanks, would take a look.

>> 
>> My suggestion is to release the lock after kstrdup() to make the example more
>> intact. But with a comment to explain the purpose here.
>> 
>> Also I found we miss the second parameter key here.
>> 
>> diff --git a/Documentation/RCU/listRCU.rst b/Documentation/RCU/listRCU.rst
>> index ed5c9d8c9afe..a3e7f8ff3a81 100644
>> --- a/Documentation/RCU/listRCU.rst
>> +++ b/Documentation/RCU/listRCU.rst
>> @@ -334,7 +334,7 @@ If the system-call audit module were to ever need to reject stale data, one way
>> to accomplish this would be to add a ``deleted`` flag and a ``lock`` spinlock to the
>> ``audit_entry`` structure, and modify audit_filter_task() as follows::
>> 
>> - static enum audit_state audit_filter_task(struct task_struct *tsk)
>> + static enum audit_state audit_filter_task(struct task_struct *tsk, char **key)
>> {
>> struct audit_entry *e;
>> enum audit_state   state;
>> @@ -349,8 +349,11 @@ to accomplish this would be to add a ``deleted`` flag and a ``lock`` spinlock to
>> return AUDIT_BUILD_CONTEXT;
>> }
>> rcu_read_unlock();
>> + /* With spinlock held, it is ok to access 'e' out
>> +                                 * of critial section */
>> if (state == AUDIT_STATE_RECORD)
>> *key = kstrdup(e->rule.filterkey, GFP_ATOMIC);
>> + spin_unlock(&e->lock);
>> return state;
>> }
>> }
>> 
>> Does it make sense to you?
>> 
>> 
>> -- 
>> Wei Yang
>> Help you, Help me
>

-- 
Wei Yang
Help you, Help me
