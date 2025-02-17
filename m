Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E272619048F;
	Mon, 17 Feb 2025 07:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739778064; cv=none; b=OprjeVvO4NJepRU6y3wi1YbYxJ0ehoPjhNMBrQr43mRmnc0Z2qa4teOsy1tJH6oxLIloHcDHJOOs1RApci6iW8WDI7NO7alMQb/53Q6+vv0Ed43TNgShH1itD1/qIl9bmH3S6bTDWxRv7X6VyLiOH92gY+9ACAId8/h92ZBGe9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739778064; c=relaxed/simple;
	bh=VoU6E0WdPE64Io1VqSxCePnL4gVF+u9gsNgh81Je13w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XTkdf0+A+1Fxv/uql33Dd3Ib03O+wfkC2dlmaFzbjiXvQstSW2rCPSsnHJQoHpgB6V2VIj2/nDyTZBGJl3pIadNe9Xn3iPIIrazW3d+V8l8bORR9A4EjV3HMUomejQuPE6AH8ZbF8BRR+ZKJlL9RjsQRgfIy1QwLJtIyNGLEj60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dRBy5t4/; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dRBy5t4/"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-aaedd529ba1so476196466b.1;
        Sun, 16 Feb 2025 23:41:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739778061; x=1740382861; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pzm/LRbGKENUzuNI+IxhBxnLqSxOmoILk4BSzuWk9EU=;
        b=dRBy5t4/NC6ZOerrk/9S/0dRWMdK666xPZzk0UQAnw1woyt1QHFopFSJM1gLgCs3+O
         CC+74NXwjR1gnvi3Ktz6lywx8j5y9wQ7dVZb2O5ZOlklJwNQ/ecY3jqyGgUSKTuKClio
         4qRtKYrqFBxvKx4B1E1NE9SCBSToP5nhUv+odhzGvYQ1PQhM20eMuqOZBJfKW1GXnvNW
         WrLYEY56EpmtZIjIjY2VSpzyFw+VSKiKq3zn8tK5h4U+yWfJfn1EkBRueoXHs3A8qCvG
         3MeMkLOyq9JTRSEYG0liWMgAXTs0wDNaSICqA4B5DzX9t4l5qifmBgcrnGnnuu2A+nv9
         V2ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739778061; x=1740382861;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pzm/LRbGKENUzuNI+IxhBxnLqSxOmoILk4BSzuWk9EU=;
        b=g9QFRd6pAsDI2J+DuoxqNBr93z4w+ZsXGieMChRwG4DtsD7o7Q8tiI6aIwHOk9UQVi
         4nGlK4nurbNX5dx0d3pxS3++VRXl7Gho82IijdU9MdvGrutKll8jFW2rsB1WjVNNkHxb
         e8JgdbBKSw94CI6PiHpp9ydvngvFl6zTIWTfs2E+++5lrvU1sfSf8oCOdQ9elRvXl0W9
         dOiQzHLIiayz6l3978c6ShLYb+yZuBM4qzrNQswhcSmM8WDDSurrroZEfAqGTXaq2PSZ
         VR/fGYIJipmumlQZm95VUYOE+cFhBuj6kSYJy+fHI8QwjN3yweeieECedJGoLMPNn6Vm
         9d4A==
X-Forwarded-Encrypted: i=1; AJvYcCXHjFeWDHi0rbB+OTz6CHGYvJ72Qp1lHF6lvLt62vJHlr/vj8yQ4Qd8KPFMGPt7nXhBfF2DncQyUVE=@vger.kernel.org, AJvYcCXHnHJ6iMlJYexQNxtyDXu1CLyiNmjqsnQ0wMB9ryOMt3YLllsJezrOzD3Xhm+Aqo1jhjEO@vger.kernel.org
X-Gm-Message-State: AOJu0YyEmEHZ1Djymko7xHCyhbyTVvYUjEAdQZI7vYP+WdBtJSvPcsMx
	8/kfikR6+PlhxJy3zrIvYEKiroTLqGl7eWuqjsSQ7OFQejPK3PaCGVPAeber
X-Gm-Gg: ASbGncu+YzHLH+BWg6BEM6w0/82kj5qbiccW45TgzLY7N6LhmUPunw1scYaxFrc3y2M
	Eom/j6floztdJ+kU4Qgc0CGAq6CZaoJadXUzegNoDYXB+5BdnBjXQAiQHFMGOWSZnfqNabtuwob
	hA2vt0z3qJP+sT09F4fpl4CZbvGfcvSjhw0mCnD4JR8PPVXEAKps79V4bjZTO8fLfjo6b0oo3rJ
	QrZjMJbk1UjrdZluUHxhznIPOZ8rtyAu+H0kY6etpSmV2tQXB4EO3nEX0kHTDJdymQ6VWn8f9tU
	4itWaBDMV9a/msU=
X-Google-Smtp-Source: AGHT+IETS/YYr1RBO5fl70gVw0CWTL6RUYYKxZj05+dv94R3beiRNefTK0Mf6pkYtj2puE6D08pH0Q==
X-Received: by 2002:a05:6402:510b:b0:5dc:a44e:7644 with SMTP id 4fb4d7f45d1cf-5e035ff9cacmr21077071a12.2.1739778060956;
        Sun, 16 Feb 2025 23:41:00 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aba5337634bsm844028766b.91.2025.02.16.23.41.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 16 Feb 2025 23:41:00 -0800 (PST)
Date: Mon, 17 Feb 2025 07:41:00 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Alan Huang <mmpgouride@gmail.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, Wei Yang <richard.weiyang@gmail.com>,
	paulmck@kernel.org, frederic@kernel.org, neeraj.upadhyay@kernel.org,
	rcu@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH] doc/RCU/listRCU: fix an example code snippets
Message-ID: <20250217074100.2wyy6akdr2j464wx@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20250101082306.10404-1-richard.weiyang@gmail.com>
 <Z7Ka8Z5RS_OwyL_G@Mac.home>
 <CDB3A2E0-A891-491E-9F7D-F09843F1A3E3@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CDB3A2E0-A891-491E-9F7D-F09843F1A3E3@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Mon, Feb 17, 2025 at 10:22:53AM +0800, Alan Huang wrote:
>On Feb 17, 2025, at 10:12, Boqun Feng <boqun.feng@gmail.com> wrote:
>> 
>> Hi Wei,
>> 
>> The change loosk good to me, thanks!
>> 
>> I queued the patch for futher reviews and tests with some changes in the
>> commit log (for title formating and a bit more explanation), please see
>> below.
>> 
>> Regards,
>> Boqun
>> 
>> On Wed, Jan 01, 2025 at 08:23:06AM +0000, Wei Yang wrote:
>>> The example code for "Eliminating Stale Data" looks not correct:
>>> 
>>>  * rcu_read_unlock() should put after kstrdup()
>>>  * spin_unlock() should be called before return
>>> 
>>> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
>> [...]
>> 
>> 
>> ------------------>8
>> Subject: [PATCH] doc/RCU/listRCU: Fix an example code snippets
>> 
>> The example code for "Eliminating Stale Data" looks not correct:
>> 
>> * rcu_read_unlock() should put after kstrdup(), because otherwise
>> entry may get freed while kstrdup() is being called.
>> 
>> * spin_unlock() should be called before return, otherwise the
>> function would return with the lock of the entry held.
>> 
>> Hence fix these.
>> 
>> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
>> Link: https://lore.kernel.org/r/20250101082306.10404-1-richard.weiyang@gmail.com
>> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
>> ---
>> Documentation/RCU/listRCU.rst | 3 ++-
>> 1 file changed, 2 insertions(+), 1 deletion(-)
>> 
>> diff --git a/Documentation/RCU/listRCU.rst b/Documentation/RCU/listRCU.rst
>> index ed5c9d8c9afe..8df50fcd69fd 100644
>> --- a/Documentation/RCU/listRCU.rst
>> +++ b/Documentation/RCU/listRCU.rst
>> @@ -348,9 +348,10 @@ to accomplish this would be to add a ``deleted`` flag and a ``lock`` spinlock to
>> rcu_read_unlock();
>> return AUDIT_BUILD_CONTEXT;
>> }
>> - rcu_read_unlock();
>> if (state == AUDIT_STATE_RECORD)
>> *key = kstrdup(e->rule.filterkey, GFP_ATOMIC);
>> + spin_unlock(&e->lock);
>
>According to the above quick quiz, we should return with the lock held.
>

Thanks, I think you have some reason.

If my understanding is correct, the example here is to emphasize we could
still access the value out of critical section but with spinlock held.

In current example, we don't return e(struct audit_entry) from
audit_filter_task(). So no one suppose to release the spinlock again. This
looks to be a mistake.

My suggestion is to release the lock after kstrdup() to make the example more
intact. But with a comment to explain the purpose here.

Also I found we miss the second parameter key here.

diff --git a/Documentation/RCU/listRCU.rst b/Documentation/RCU/listRCU.rst
index ed5c9d8c9afe..a3e7f8ff3a81 100644
--- a/Documentation/RCU/listRCU.rst
+++ b/Documentation/RCU/listRCU.rst
@@ -334,7 +334,7 @@ If the system-call audit module were to ever need to reject stale data, one way
 to accomplish this would be to add a ``deleted`` flag and a ``lock`` spinlock to the
 ``audit_entry`` structure, and modify audit_filter_task() as follows::
 
-	static enum audit_state audit_filter_task(struct task_struct *tsk)
+	static enum audit_state audit_filter_task(struct task_struct *tsk, char **key)
 	{
 		struct audit_entry *e;
 		enum audit_state   state;
@@ -349,8 +349,11 @@ to accomplish this would be to add a ``deleted`` flag and a ``lock`` spinlock to
 					return AUDIT_BUILD_CONTEXT;
 				}
 				rcu_read_unlock();
+				/* With spinlock held, it is ok to access 'e' out
+                                 * of critial section */
 				if (state == AUDIT_STATE_RECORD)
 					*key = kstrdup(e->rule.filterkey, GFP_ATOMIC);
+				spin_unlock(&e->lock);
 				return state;
 			}
 		}

Does it make sense to you?


-- 
Wei Yang
Help you, Help me
